import 'package:equatable/equatable.dart';

class DriverWalletEntity extends Equatable {
  final double
  totalEarnings; // إجمالي الأرباح التراكمية التي حققها الكابتن من التوصيل الحُر
  final double availableBalance; // الرصيد الحالي المتوفر والقابل للسحب كاش
  final int completedOrders; // عدد الطلبات الناجحة التي قام المندوب بتسليمها في نطاق الـ 30 كم

  const DriverWalletEntity({
    required this.totalEarnings,
    required this.availableBalance,
    required this.completedOrders,
  });

  @override
  List<Object?> get props => [totalEarnings, availableBalance, completedOrders];
}
