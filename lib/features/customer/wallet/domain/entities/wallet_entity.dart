import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final double
  balance; // الرصيد الحالي المتوفر في محفظة العميل (بالجنيه المصري)
  final String currency; // العملة المستخدمة للتسعير (ج.م)

  const WalletEntity({required this.balance, required this.currency});

  @override
  List<Object?> get props => [balance, currency];
}
