import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.phoneNumber,
    required super.token,
  });

  // دالة تحويل الـ JSON القادم من السيرفر إلى كائن UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      phoneNumber: json['phone_number'] ?? '',
      token: json['token'] ?? '',
    );
  }

  // دالة تحويل الكائن إلى Map (تم تصحيح القوس في النهاية هنا)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'token': token,
    }; // هنا تم التعديل إلى } بدلاً من )
  }
}
