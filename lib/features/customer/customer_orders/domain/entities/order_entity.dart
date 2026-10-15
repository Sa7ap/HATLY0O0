import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String orderDetails; // تفاصيل الأغراض الحرة التي كتبها العميل
  final String storeName; // اسم المتجر المحدد أو عبارة "أي متجر متاح"
  final double itemsPrice; // السعر التقديري للأغراض الذي يكتبه العميل
  final double
  deliveryFee; // رسوم التوصيل الذكية (المحسوبة أوتوماتيكياً أو يدوياً)
  final String
  orderStatus; // حالة الطلب (جاري البحث، جاري الشراء، جاري التوصيل)

  const OrderEntity({
    required this.id,
    required this.orderDetails,
    required this.storeName,
    required this.itemsPrice,
    required this.deliveryFee,
    required this.orderStatus,
  });

  @override
  List<Object?> get props => [
    id,
    orderDetails,
    storeName,
    itemsPrice,
    deliveryFee,
    orderStatus,
  ];
}
