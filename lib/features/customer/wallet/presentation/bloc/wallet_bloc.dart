import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_wallet_balance_usecase.dart';
import '../../domain/usecases/update_wallet_balance_usecase.dart';
import '../../domain/usecases/get_wallet_transactions_usecase.dart'; // استدعاء حالة استخدام كشف الحساب الجديدة
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletBalanceUseCase getWalletBalanceUseCase;
  final UpdateWalletBalanceUseCase updateWalletBalanceUseCase;
  final GetWalletTransactionsUseCase
  getWalletTransactionsUseCase; // حقن التبعية الجديدة

  WalletBloc({
    required this.getWalletBalanceUseCase,
    required this.updateWalletBalanceUseCase,
    required this.getWalletTransactionsUseCase, // إلزام التبعية في الـ Constructor
  }) : super(WalletInitial()) {
    // 1. معالجة حدث طلب جلب رصيد المحفظة الحالي للعميل
    on<GetWalletBalanceEvent>((event, emit) async {
      emit(WalletLoading());
      final result = await getWalletBalanceUseCase.call();
      result.fold(
        (failure) => emit(WalletError(failure.message)),
        (wallet) => emit(WalletLoaded(wallet)),
      );
    });

    // 2. معالجة حدث تحديث أو شحن رصيد المحفظة
    on<UpdateWalletBalanceEvent>((event, emit) async {
      emit(WalletLoading());
      final result = await updateWalletBalanceUseCase.call(event.amount);
      result.fold(
        (failure) => emit(WalletError(failure.message)),
        (_) => add(
          GetWalletBalanceEvent(),
        ), // إعادة جلب الرصيد المحدث تلقائياً فور الشحن
      );
    });

    // 3. معالجة حدث طلب جلب كشف حساب المعاملات الماليّة المفصلة ديناميكياً
    on<GetWalletTransactionsEvent>((event, emit) async {
      emit(WalletLoading()); // تشغيل مؤشر التحميل الذكي

      final result = await getWalletTransactionsUseCase.call();

      result.fold(
        (failure) => emit(WalletError(failure.message)),
        (transactions) => emit(WalletTransactionsLoadedState(transactions)),
      );
    });
  }
}
