import '../../domain/entities/driver_wallet_entity.dart';

class DriverWalletModel extends DriverWalletEntity {
  const DriverWalletModel({
    required super.totalEarnings,
    required super.availableBalance,
    required super.completedOrders,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجى داخل التطبيق
  factory DriverWalletModel.fromJson(Map<String, dynamic> json) {
    return DriverWalletModel(
      totalEarnings: (json['total_earnings'] as num? ?? 0.0).toDouble(),
      availableBalance: (json['available_balance'] as num? ?? 0.0).toDouble(),
      completedOrders: json['completed_orders'] as int? ?? 0,
    );
  }

  // دالة تحويل كائن محفظة المندوب إلى خريطة بيانات (Map JSON) لإرسالها وتحديثها بالسيرفر
  Map<String, dynamic> toJson() {
    return {
      'total_earnings': totalEarnings,
      'available_balance': availableBalance,
      'completed_orders': completedOrders,
    };
  }
}
