import 'package:equatable/equatable.dart';

class PastOrderEntity extends Equatable {
  final String orderCode; // كود الطلب الفريد (يبدأ من 00000001)
  final String dateTime; // تاريخ ووقت إتمام الطلب والتوصيل
  final String orderDetails; // تفاصيل السلع والوجبات المشتراة
  final String pickupLocation; // موقع استلام الشحنة (المتجر)
  final String deliveryLocation; // موقع تسليم الشحنة (منزل العميل)
  final double deliveryFee; // رسوم التوصيل الجغرافية الصافية
  final double driverRating; // التقييم الممنوح للكابتن من ٥ نجمات
  final double storeRating; // التقييم الممنوح للمتجر من ٥ نجمات

  const PastOrderEntity({
    required this.orderCode,
    required this.dateTime,
    required this.orderDetails,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.deliveryFee,
    required this.driverRating,
    required this.storeRating,
  });

  @override
  List<Object?> get props => [
    orderCode,
    dateTime,
    orderDetails,
    pickupLocation,
    deliveryLocation,
    deliveryFee,
    driverRating,
    storeRating,
  ];
}
