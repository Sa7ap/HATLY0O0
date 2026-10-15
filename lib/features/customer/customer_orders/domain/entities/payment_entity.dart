import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String transactionId; // معرف المعاملة المالي الفريد
  final String orderId; // رقم الطلب المرتبط بالدورة المالية
  final String paymentMethod; // طريقة السداد (مثال: 'WALLET' أو 'CASH')
  final double amountPaid; // المبلغ الإجمالي المستقطع من العميل
  final String paymentStatus; // حالة السداد (مثال: 'SUCCESS')

  // --- الحقول المفككة الجديدة المضافة: لفرز مستحقات المنظومة الثلاثية 2026 ---
  final double merchantShare; // صافي مستحقات صاحب المتجر/الصيدلية عن السلع
  final double deliveryFee; // صافي حق مندوب التوصيل عن الوردية الجغرافية
  final double platformFee; // نسبة عمولة تشغيل منصة هاتلي الذكية

  const PaymentEntity({
    required this.transactionId,
    required this.orderId,
    required this.paymentMethod,
    required this.amountPaid,
    required this.paymentStatus,
    required this.merchantShare,
    required this.deliveryFee,
    required this.platformFee,
  });

  @override
  List<Object?> get props => [
    transactionId,
    orderId,
    paymentMethod,
    amountPaid,
    paymentStatus,
    merchantShare,
    deliveryFee,
    platformFee,
  ];
}
