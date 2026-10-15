import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id; // المعرف الفريد للعنوان المسجل
  final String title; // اسم العنوان (مثال: المنزل 🏠، العمل 💼)
  final String fullAddress; // تفاصيل العنوان (اسم الشارع، رقم العقار، المعالم)
  final String city; // المدينة أو المركز (مثال: سمنود)
  final double latitude; // الإحداثي الجغرافي لخط العرض
  final double longitude; // الإحداثي الجغرافي لخط الطول

  const AddressEntity({
    required this.id,
    required this.title,
    required this.fullAddress,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    fullAddress,
    city,
    latitude,
    longitude,
  ];
}
