import '../../domain/entities/evaluation_entity.dart';

class EvaluationModel extends EvaluationEntity {
  const EvaluationModel({
    required super.orderId,
    required super.driverRating,
    required super.merchantRating,
    required super.comment,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجي داخل التطبيق
  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      orderId: json['order_id'] as String? ?? '',
      driverRating: (json['driver_rating'] as num? ?? 5.0).toDouble(),
      merchantRating: (json['merchant_rating'] as num? ?? 5.0).toDouble(),
      comment: json['comment'] as String? ?? '',
    );
  }

  // دالة تحويل كائن التقييم إلى خريطة بيانات (Map JSON) لإرسالها وتخزينها بالسيرفر
  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'driver_rating': driverRating,
      'merchant_rating': merchantRating,
      'comment': comment,
    };
  }
}
