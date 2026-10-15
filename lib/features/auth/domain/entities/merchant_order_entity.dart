import 'package:equatable/equatable.dart';

class MerchantOrderEntity extends Equatable {
  final String id;            // المعرف الفريد للطلب القادم للمتجر
  final String itemsSummary;  // ملخص المنتجات والكميات المطلوبة (مثال: وجبة سوبر كومبو عدد: 2)
  final double itemsPrice;   // إجمالي ثمن البضائع الصافي المرتجع لحساب التاجر
  final String customerPhone; // رقم هاتف العميل للتواصل عند الحاجة
  final String status;        // حالة الطلب الحالية (مثال: pending، preparing، ready)

  const MerchantOrderEntity({
    required this.id,
    required this.itemsSummary,
    required this.itemsPrice,
    required this.customerPhone,
    required this.status,
  });

  @override
  List<Object?> get props => [id, itemsSummary, itemsPrice, customerPhone, status];
}
