import 'package:equatable/equatable.dart';

class MerchantStatsEntity extends Equatable {
  final double
  totalSales; // إجمالي المبيعات الماليّة التراكمية بالجنيه المصري (ج.م)
  final int
  successfulOrders; // عدد الطلبات الناجحة المكتملة التي خرجت من المتجر
  final int
  activeProducts; // عدد السلع والمنتجات النشطة المتاحة في مخزون التاجر حالياً

  const MerchantStatsEntity({
    required this.totalSales,
    required this.successfulOrders,
    required this.activeProducts,
  });

  @override
  List<Object?> get props => [totalSales, successfulOrders, activeProducts];
}
