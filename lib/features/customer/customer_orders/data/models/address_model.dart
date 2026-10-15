import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.title,
    required super.fullAddress,
    required super.city,
    required super.latitude,
    required super.longitude,
  });

  // دالة جلب البيانات وتفكيك خريطة JSON المرتجعة من خوادم الشبكة
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      fullAddress: json['full_address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      latitude: (json['latitude'] as num? ?? 30.9575).toDouble(),
      longitude: (json['longitude'] as num? ?? 31.2594).toDouble(),
    );
  }

  // دالة تحويل الكائن إلى خريطة JSON لضخه وتخزينه بقواعد البيانات
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'full_address': fullAddress,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
