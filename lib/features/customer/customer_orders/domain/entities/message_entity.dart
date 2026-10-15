import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String messageId; // المعرف الفريد لكل رسالة نصية بالمنظومة
  final String senderId; // معرف المرسل (مثال: 'customer' أو 'driver')
  final String text; // محتوى النص المكتوب الموجه للكابتن
  final String timestamp; // توقيت إرسال وفحص الرسالة الفوري

  const MessageEntity({
    required this.messageId,
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [messageId, senderId, text, timestamp];
}
