import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.time,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجي داخل التطبيق
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      time: json['time'] as String? ?? '',
    );
  }

  // دالة تحويل كائن الإشعار إلى خريطة بيانات (Map JSON) لإرسالها وتحديثها بالسيرفر
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body, 'time': time};
  }
}
