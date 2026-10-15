import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/domain/usecases/add_product_usecase.dart';
import '../../auth/domain/usecases/get_merchant_stats_usecase.dart';
import '../../auth/domain/usecases/get_merchant_orders_usecase.dart'; // استدعاء حالة استخدام جلب الطلبات
import '../../auth/domain/usecases/update_merchant_order_status_usecase.dart'; // استدعاء حالة استخدام تحديث الطلبات
import 'merchant_product_event.dart';
import 'merchant_product_state.dart';

class MerchantProductBloc
    extends Bloc<MerchantProductEvent, MerchantProductState> {
  final AddProductUseCase addProductUseCase;
  final GetMerchantStatsUseCase getMerchantStatsUseCase;
  final GetMerchantOrdersUseCase
  getMerchantOrdersUseCase; // حقن التبعية الجديدة لطلبات المتجر
  final UpdateMerchantOrderStatusUseCase
  updateMerchantOrderStatusUseCase; // حقن تبعية التحديث للطلبات

  MerchantProductBloc({
    required this.addProductUseCase,
    required this.getMerchantStatsUseCase,
    required this.getMerchantOrdersUseCase,
    required this.updateMerchantOrderStatusUseCase,
  }) : super(MerchantProductInitialState()) {
    // 1. معالجة حدث طلب إضافة منتج جديد التابع للتاجر
    on<AddProductRequestedEvent>((event, emit) async {
      emit(MerchantProductLoadingState());
      final result = await addProductUseCase.call(
        name: event.name,
        price: event.price,
        description: event.description,
      );
      result.fold(
        (failure) =>
            emit(MerchantProductFailureState(errorMessage: failure.message)),
        (_) => emit(AddProductSuccessState()),
      );
    });

    // 2. معالجة حدث طلب جلب وتحديث المبيعات والأرباح التراكمية للمتجر ديناميكياً
    on<GetMerchantStatsRequestedEvent>((event, emit) async {
      emit(MerchantProductLoadingState());
      final result = await getMerchantStatsUseCase.call();
      result.fold(
        (failure) =>
            emit(MerchantProductFailureState(errorMessage: failure.message)),
        (stats) => emit(GetMerchantStatsSuccessState(stats: stats)),
      );
    });

    // 3. معالجة حدث طلب جلب قائمة طلبات المتجر القادمة من العملاء حركياً
    on<GetMerchantOrdersEvent>((event, emit) async {
      emit(MerchantProductLoadingState()); // تشغيل مؤشر التحميل
      final result = await getMerchantOrdersUseCase.call();
      result.fold(
        (failure) =>
            emit(MerchantProductFailureState(errorMessage: failure.message)),
        (orders) => emit(GetMerchantOrdersSuccessState(orders: orders)),
      );
    });

    // 4. معالجة حدث طلب تحديث حالة تحضير وطهي الطلب داخل متجر التاجر
    on<UpdateMerchantOrderStatusEvent>((event, emit) async {
      emit(MerchantProductLoadingState());
      final result = await updateMerchantOrderStatusUseCase.call(
        orderId: event.orderId,
        newStatus: event.newStatus,
      );
      result.fold(
        (failure) =>
            emit(MerchantProductFailureState(errorMessage: failure.message)),
        (_) => emit(
          UpdateMerchantOrderStatusSuccessState(
            orderId: event.orderId,
            newStatus: event.newStatus,
          ),
        ),
      );
    });
  }
}
