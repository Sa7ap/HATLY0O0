import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.messageId,
    required super.senderId,
    required super.text,
    required super.timestamp,
  });

  // دالة جلب وقراءة مصفوفة الرسائل القادمة من السيرفر وفك ترميز الـ JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['message_id'] as String? ?? '',
      senderId: json['sender_id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
    );
  }

  // دالة تحويل كائن الرسالة المكتوبة لخريطة JSON لضخها فوراً بقواعد البيانات الحية
  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'sender_id': senderId,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
