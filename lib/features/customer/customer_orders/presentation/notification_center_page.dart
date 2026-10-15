import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/customer_order_bloc.dart';
import 'bloc/customer_order_event.dart';
import 'bloc/customer_order_state.dart';
import '../domain/entities/notification_entity.dart';

class NotificationCenterPage extends StatefulWidget {
  const NotificationCenterPage({super.key});

  @override
  State<NotificationCenterPage> createState() => _NotificationCenterPageState();
}

class _NotificationCenterPageState extends State<NotificationCenterPage> {
  @override
  void initState() {
    super.initState();
    // إطلاق حدث طلب جلب قائمة التنبيهات تلقائياً فور فتح مركز الإشعارات
    context.read<CustomerOrderBloc>().add(GetNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // شريط الترويسة العلوي الأنيق لمركز تنبيهات العميل
      appBar: AppBar(
        title: const Text(
          'مركز التنبيهات 🔔',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // سيتم استدعاء الـ BlocBuilder وقائمة التنبيهات التفاعلية بالأسفل في الجزء الثاني...
      body: SafeArea(
        child: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
          builder: (context, state) {
            List<NotificationEntity> notificationsList = [];

            // Extract live records whenever the asynchronous loader finishes successfully
            if (state is GetNotificationsSuccessState) {
              notificationsList = state.notifications;
            }

            if (state is CustomerOrderLoadingState &&
                notificationsList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<CustomerOrderBloc>().add(GetNotificationsEvent());
              },
              color: Colors.deepOrange,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  notificationsList.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(24),
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: const Center(
                            child: Text(
                              'صندوق التنبيهات فارغ حالياً.',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notificationsList.length,
                          itemBuilder: (context, index) {
                            final notification = notificationsList[index];
                            return _buildNotificationCardItem(notification);
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Visual anchoring utility to compile functional cards cleanly based on message headers
  Widget _buildNotificationCardItem(NotificationEntity not) {
    IconData iconData = Icons.notifications_active_rounded;
    Color iconColor = Colors.deepOrange;

    // Evaluate message traits silently to swap aesthetic profiles
    if (not.title.contains('المتجر') || not.title.contains('🧑‍🍳')) {
      iconData = Icons.soup_kitchen_rounded;
      iconColor = Colors.orange;
    } else if (not.title.contains('قبول') || not.title.contains('🏁')) {
      iconData = Icons.local_shipping_rounded;
      iconColor = Colors.green;
    } else if (not.title.contains('شحن') || not.title.contains('💳')) {
      iconData = Icons.account_balance_wallet_rounded;
      iconColor = Colors.blue;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      not.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Text(
                      not.time,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  not.body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: 'Cairo',
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
