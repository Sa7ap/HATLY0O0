import '../../domain/entities/past_order_entity.dart';

class PastOrderModel extends PastOrderEntity {
  const PastOrderModel({
    required super.orderCode,
    required super.dateTime,
    required super.orderDetails,
    required super.pickupLocation,
    required super.deliveryLocation,
    required super.deliveryFee,
    required super.driverRating,
    required super.storeRating,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجى داخل الأرشيف
  factory PastOrderModel.fromJson(Map<String, dynamic> json) {
    return PastOrderModel(
      orderCode: json['order_code'] as String? ?? '',
      dateTime: json['date_time'] as String? ?? '',
      orderDetails: json['order_details'] as String? ?? '',
      pickupLocation: json['pickup_location'] as String? ?? '',
      deliveryLocation: json['delivery_location'] as String? ?? '',
      deliveryFee: (json['delivery_fee'] as num? ?? 0.0).toDouble(),
      driverRating: (json['driver_rating'] as num? ?? 5.0).toDouble(),
      storeRating: (json['store_rating'] as num? ?? 5.0).toDouble(),
    );
  }

  // دالة تحويل كائن الأرشيف إلى خريطة بيانات (Map JSON) لإرسالها وتخزينها
  Map<String, dynamic> toJson() {
    return {
      'order_code': orderCode,
      'date_time': dateTime,
      'order_details': orderDetails,
      'pickup_location': pickupLocation,
      'delivery_location': deliveryLocation,
      'delivery_fee': deliveryFee,
      'driver_rating': driverRating,
      'store_rating': storeRating,
    };
  }
}
