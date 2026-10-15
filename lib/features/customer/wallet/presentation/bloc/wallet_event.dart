import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

// 1. الحدث القديم لجلب رصيد المحفظة الحالي للعميل
class GetWalletBalanceEvent extends WalletEvent {}

// 2. الحدث القديم لتحديث أو شحن رصيد المحفظة
class UpdateWalletBalanceEvent extends WalletEvent {
  final double amount;

  const UpdateWalletBalanceEvent(this.amount);

  @override
  List<Object?> get props => [amount];
}

// --- الحدث الجديد المضاف لإدارة كشف حساب العميل حركياً لعام 2026 ---

// 3. حدث طلب جلب وتحديث قائمة المعاملات والحركات المالية للمحفظة
class GetWalletTransactionsEvent extends WalletEvent {}
