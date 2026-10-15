import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id; // المعرف الفريد للإشعار
  final String title; // عنوان التنبيه (مثال: تحديث من المتجر 🧑‍🍳)
  final String
  body; // نص الإشعار التفصيلي (مثال: طلبك الآن قيد التحضير في المطبخ)
  final String time; // وقت إطلاق التنبيه الفوري

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
  });

  @override
  List<Object?> get props => [id, title, body, time];
}
