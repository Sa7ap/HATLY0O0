import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.orderDetails,
    required super.storeName,
    required super.itemsPrice,
    required super.deliveryFee,
    required super.orderStatus,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجى داخل التطبيق
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      orderDetails: json['order_details'] as String? ?? '',
      storeName:
          json['store_name'] as String? ?? 'أي متجر متاح (يختاره المندوب)',
      itemsPrice: (json['items_price'] as num? ?? 0.0).toDouble(),
      deliveryFee: (json['delivery_fee'] as num? ?? 20.0).toDouble(),
      orderStatus: json['order_status'] as String? ?? 'pending',
    );
  }

  // دالة تحويل كائن الطلب الحر داخل التطبيق إلى خريطة بيانات (Map JSON) لإرسالها للسيرفر
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_details': orderDetails,
      'store_name': storeName,
      'items_price': itemsPrice,
      'delivery_fee': deliveryFee,
      'order_status': orderStatus,
    };
  }
}
