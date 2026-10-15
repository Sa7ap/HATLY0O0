import 'package:equatable/equatable.dart';

import '../../domain/entities/wallet_entity.dart';
import '../../domain/entities/wallet_transaction_entity.dart'; // استدعاء كيان المعاملات الجديد

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

// 1. الحالات الابتدائية والتحميل العامة للمحفظة
class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

// 2. حالة نجاح جلب رصيد المحفظة الإجمالي (الـ 250 ج.م والعملة)
class WalletLoaded extends WalletState {
  final WalletEntity wallet;

  const WalletLoaded(this.wallet);

  @override
  List<Object?> get props => [wallet];
}

// --- الحالات الجديدة المضافة: لإدارة كشف الحساب حركياً بنقاء تّام ---

// 3. حالة نجاح جلب وتحديث مصفوفة الحركات الماليّة لكشف الحساب
class WalletTransactionsLoadedState extends WalletState {
  final List<WalletTransactionEntity> transactions;

  const WalletTransactionsLoadedState(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

// 4. حالة حدوث خطأ مالي أو فشل في الاتصال بالسيرفر
class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object?> get props => [message];
}
