import 'package:equatable/equatable.dart';

class EvaluationEntity extends Equatable {
  final String orderId; // رقم الطلب الحُر المراد تقييمه
  final double driverRating; // تقييم الكابتن من ١ إلى ٥ نجمات
  final double merchantRating; // تقييم المتجر/المطبخ من ١ إلى ٥ نجمات
  final String comment; // الملاحظات النصية أو شكوى العميل إن وجدت

  const EvaluationEntity({
    required this.orderId,
    required this.driverRating,
    required this.merchantRating,
    required this.comment,
  });

  @override
  List<Object?> get props => [orderId, driverRating, merchantRating, comment];
}
