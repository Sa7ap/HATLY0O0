import '../../domain/entities/merchant_stats_entity.dart';

class MerchantStatsModel extends MerchantStatsEntity {
  const MerchantStatsModel({
    required super.totalSales,
    required super.successfulOrders,
    required super.activeProducts,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجى داخل التطبيق
  factory MerchantStatsModel.fromJson(Map<String, dynamic> json) {
    return MerchantStatsModel(
      totalSales: (json['total_sales'] as num? ?? 0.0).toDouble(),
      successfulOrders: json['successful_orders'] as int? ?? 0,
      activeProducts: json['active_products'] as int? ?? 0,
    );
  }

  // دالة تحويل كائن الإحصائيات إلى خريطة بيانات (Map JSON) لإرسالها أو تحديثها
  Map<String, dynamic> toJson() {
    return {
      'total_sales': totalSales,
      'successful_orders': successfulOrders,
      'active_products': activeProducts,
    };
  }
}
