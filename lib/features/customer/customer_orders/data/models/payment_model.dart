import '../../domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.transactionId,
    required super.orderId,
    required super.paymentMethod,
    required super.amountPaid,
    required super.paymentStatus,
    required super.merchantShare,
    required super.deliveryFee,
    required super.platformFee,
  });

  // دالة تفكيك خريطة JSON المستقبلة لفرز كشوف حساب الأطراف الثلاثة بدقة
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      transactionId: json['transaction_id'] as String? ?? '',
      orderId: json['order_id'] as String? ?? '',
      paymentMethod: json['payment_method'] as String? ?? '',
      amountPaid: (json['amount_paid'] as num? ?? 0.0).toDouble(),
      paymentStatus: json['payment_status'] as String? ?? '',
      merchantShare: (json['merchant_share'] as num? ?? 0.0).toDouble(),
      deliveryFee: (json['delivery_fee'] as num? ?? 0.0).toDouble(),
      platformFee: (json['platform_fee'] as num? ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'order_id': orderId,
      'payment_method': paymentMethod,
      'amount_paid': amountPaid,
      'payment_status': paymentStatus,
      'merchant_share': merchantShare,
      'delivery_fee': deliveryFee,
      'platform_fee': platformFee,
    };
  }
}
