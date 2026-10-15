import 'package:equatable/equatable.dart';

class DriverShiftEntity extends Equatable {
  final String id; // المعرف الفريد لطلب الوردية
  final String orderSummary; // ملخص الأغراض الموصلة (مثال: وجبة برجر)
  final double deliveryEarnings; // صافي ربح التوصيل المحقق للكابتن
  final String distance; // المسافة الجغرافية المقطوعة (مثال: 4.2 كم)
  final String date; // تاريخ ووقت إتمام التوصيل

  const DriverShiftEntity({
    required this.id,
    required this.orderSummary,
    required this.deliveryEarnings,
    required this.distance,
    required this.date,
  });

  @override
  List<Object?> get props => [
    id,
    orderSummary,
    deliveryEarnings,
    distance,
    date,
  ];
}
