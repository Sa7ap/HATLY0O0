// lib/features/customer/home/presentation/notification_center_page.dart
import 'package:flutter/material.dart';

class NotificationCenterPage extends StatelessWidget {
  const NotificationCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة تاريخية تجريبية تحاكي أرشيف الإشعارات المرسلة للعميل
    final List<Map<String, String>> notificationsArchive = [
      {
        'title': 'وصل المندوب "أحمد عصام" إلى موقع التسليم 📍',
        'time': '11:58 مساءً',
        'details': 'المندوب متواجد الآن عند مدخل البناية الخاصة بك، يرجى الاستعداد لاستلام الطلب وتجهيز الحساب.',
        'isNew': 'true',
      },
      {
        'title': 'المندوب "أحمد عصام" في طريقه إليك 🛵',
        'time': '11:52 مساءً',
        'details': 'تم استلام الوجبات بنجاح من المطعم والمندوب يتحرك الآن باتجاه موقع تسليمك المحدد على الخريطة.',
        'isNew': 'false',
      },
      {
        'title': 'تم قبول الطلب من المندوب "أحمد عصام" 🤝',
        'time': '11:46 مساءً',
        'details': 'وافق الكابتن على القيمة السعرية المحددة وجاري التوجه لموقع الاستلام لتعبئة طلبك.',
        'isNew': 'false',
      },
      {
        'title': 'تم إرسال الطلب بنجاح 🎉',
        'time': '11:45 مساءً',
        'details': 'تم رفع تفاصيل طلبك (وجبة كومبو شاورما) إلى النظام بنجاح وجاري العثور على المندوب الأقرب.',
        'isNew': 'false',
      }
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('مركز الإشعارات 🔔', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: notificationsArchive.isEmpty
          ? const Center(
              child: Text('قائمة الإشعارات فارغة حالياً 📥', style: TextStyle(color: Colors.grey, fontSize: 14)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: notificationsArchive.length,
              itemBuilder: (context, index) {
                final item = notificationsArchive[index];
                final bool isNew = item['isNew'] == 'true';

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  color: isNew ? Colors.deepOrange.withValues(alpha: 0.04) : Colors.grey.withValues(alpha: 0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: isNew ? Colors.deepOrange.withValues(alpha: 0.2) : Colors.transparent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['title'] ?? '',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isNew ? Colors.deepOrange : Colors.black87,
                                ),
                              ),
                            ),
                            Text(
                              item['time'] ?? '',
                              style: const TextStyle(fontSize: 11, color: Colors.black45),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['details'] ?? '',
                          style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
