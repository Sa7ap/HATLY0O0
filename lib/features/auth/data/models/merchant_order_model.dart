import '../../domain/entities/merchant_order_entity.dart';

class MerchantOrderModel extends MerchantOrderEntity {
  const MerchantOrderModel({
    required super.id,
    required super.itemsSummary,
    required super.itemsPrice,
    required super.customerPhone,
    required super.status,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجى داخل التطبيق
  factory MerchantOrderModel.fromJson(Map<String, dynamic> json) {
    return MerchantOrderModel(
      id: json['id'] as String? ?? '',
      itemsSummary: json['items_summary'] as String? ?? '',
      itemsPrice: (json['items_price'] as num? ?? 0.0).toDouble(),
      customerPhone: json['customer_phone'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
    );
  }

  // دالة تحويل كائن الطلب إلى خريطة بيانات (Map JSON) لإرسالها وتحديثها بالسيرفر
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items_summary': itemsSummary,
      'items_price': itemsPrice,
      'customer_phone': customerPhone,
      'status': status,
    };
  }
}
