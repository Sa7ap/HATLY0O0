import '../../domain/entities/driver_shift_entity.dart';

class DriverShiftModel extends DriverShiftEntity {
  const DriverShiftModel({
    required super.id,
    required super.orderSummary,
    required super.deliveryEarnings,
    required super.distance,
    required super.date,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجى داخل التطبيق
  factory DriverShiftModel.fromJson(Map<String, dynamic> json) {
    return DriverShiftModel(
      id: json['id'] as String? ?? '',
      orderSummary: json['order_summary'] as String? ?? '',
      deliveryEarnings: (json['delivery_earnings'] as num? ?? 0.0).toDouble(),
      distance: json['distance'] as String? ?? '',
      date: json['date'] as String? ?? '',
    );
  }

  // دالة تحويل كائن الوردية إلى خريطة بيانات (Map JSON) لإرسالها وتحديثها بالسيرفر
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_summary': orderSummary,
      'delivery_earnings': deliveryEarnings,
      'distance': distance,
      'date': date,
    };
  }
}
