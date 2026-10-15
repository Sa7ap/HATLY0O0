import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/customer_order_bloc.dart';
import 'bloc/customer_order_event.dart';
import 'bloc/customer_order_state.dart';
import '../domain/entities/message_entity.dart';

class PastOrdersView extends StatefulWidget {
  final String orderId;

  const PastOrdersView({super.key, required this.orderId});

  @override
  State<PastOrdersView> createState() => _PastOrdersViewState();
}

class _PastOrdersViewState extends State<PastOrdersView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 1. إطلاق حدث جلب وتحديث رسائل الشات الحية تلقائياً فور فتح غرفة المحادثة 2026
    context.read<CustomerOrderBloc>().add(
      GetChatMessagesEvent(orderId: widget.orderId),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // دالة مساعدة لتحريك الشات لأسفل تلقائياً عند استقبال أو بث رسائل جديدة لتأمين سلاسة الواجهة
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      // 2. شريط الترويسة العلوي الأنيق لغرفة المحادثة الفورية وتوجيه الكابتن الجغرافي
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              child: const Icon(
                Icons.delivery_dining_rounded,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'كابتن التوصيل 🚴',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  'محادثة الطلب #${widget.orderId}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // يتبع مباشرة وتلقائياً الجزء 2 من 2 لبناء مكدس الرسائل وحقل الإدخال الصارم...
      body: SafeArea(
        child: BlocConsumer<CustomerOrderBloc, CustomerOrderState>(
          listener: (context, state) {
            // إعادة جلب وتحديث الرسائل فور نجاح عملية الإرسال بالسيرفر لتنشيط الشاشة
            if (state is SendChatMessageSuccessState) {
              _messageController.clear();
              context.read<CustomerOrderBloc>().add(
                GetChatMessagesEvent(orderId: widget.orderId),
              );
            }
          },
          builder: (context, state) {
            List<MessageEntity> messagesList = [];

            // استخراج قائمة رسائل المحادثة فور تحميلها بنجاح لتغذية الـ UI
            if (state is GetChatMessagesSuccessState) {
              messagesList = state.messages;
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scrollToBottom(),
              );
            }

            return Column(
              children: [
                // 3. منطقة استعراض فقاعات الرسائل الرأسية المتبادلة
                Expanded(
                  child:
                      messagesList.isEmpty && state is CustomerOrderLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            context.read<CustomerOrderBloc>().add(
                              GetChatMessagesEvent(orderId: widget.orderId),
                            );
                          },
                          color: Colors.green,
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: messagesList.length,
                            itemBuilder: (context, index) {
                              final message = messagesList[index];
                              final isMe = message.senderId == 'customer';
                              return _buildChatBubbleItem(message, isMe);
                            },
                          ),
                        ),
                ),

                // 4. لوحة حقل الإدخال وكتابة التوجيهات النصية باللغة العربية الصارمة RTL
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Cairo',
                          ),
                          textDirection: TextDirection
                              .rtl, // توجيه النص للمحاذاة العربية الصائبة
                          decoration: InputDecoration(
                            hintText: 'اكتب توجيهاتك للكابتن هنا...',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'Cairo',
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F9FA),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // زر البث الفوري الحركي للرسائل
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            final text = _messageController.text.trim();
                            if (text.isNotEmpty) {
                              final newMessage = MessageEntity(
                                messageId: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                senderId: 'customer',
                                text: text,
                                timestamp: 'الآن',
                              );
                              context.read<CustomerOrderBloc>().add(
                                SendChatMessageEvent(
                                  orderId: widget.orderId,
                                  message: newMessage,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // 5. ودجت تنسيق وهندسة زوايا فقاعات الشات الجغرافية
  Widget _buildChatBubbleItem(MessageEntity message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF1B5E20) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe
                ? const Radius.circular(16)
                : Radius.zero, // استخدام التوجيه البرمي الصائب لـ Flutter
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
          border: isMe ? null : Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          // تصحيح: حذف السطر المشوّه والإبقاء على محاذاة العناصر الصائبة فقط
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,

              style: TextStyle(
                fontSize: 12.5,
                color: isMe ? Colors.white : Colors.black87,
                fontFamily: 'Cairo',
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.timestamp,
              style: TextStyle(
                fontSize: 9,
                color: isMe ? Colors.white70 : Colors.grey,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
