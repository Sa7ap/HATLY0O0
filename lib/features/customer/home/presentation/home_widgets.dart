// lib/customer_home_widgets.dart
import 'package:flutter/material.dart';

import '../../categories/presentation/restaurants_page.dart'; // استدعاء صفحة المطاعم
import '../../categories/presentation/supermarket_page.dart'; // استدعاء صفحة السوبر ماركت
import '../../categories/presentation/pharmacy_page.dart'; // استدعاء صفحة الصيدليات
import '../../categories/presentation/vegetables_page.dart'; // استدعاء صفحة الخضروات

class CustomerHomeWidgets extends StatelessWidget {
  const CustomerHomeWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة الأقسام الرئيسية الأربعة (تم تعديل العنوان الثالث إلى صيدليات)
    final List<Map<String, dynamic>> items = [
      {
        'title': 'مطاعم',
        'icon': Icons.restaurant,
        'color': Colors.orange,
        'page': const RestaurantsPage(),
      },
      {
        'title': 'سوبر ماركت',
        'icon': Icons.local_grocery_store,
        'color': Colors.green,
        'page': const SupermarketPage(),
      },
      {
        'title': 'صيدليات',
        'icon': Icons.medical_services,
        'color': Colors.blue,
        'page': const PharmacyPage(),
      },
      {
        'title': 'خضروات',
        'icon': Icons.local_mall,
        'color': Colors.green,
        'page': const VegetablesPage(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'أو تصفح الأقسام الرئيسية المتاحة 🛒',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 8,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              // 💡 ربط تفاعلي ذكي لنقل العميل للصفحة المخصصة عند الضغط على القسم
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => items[index]['page']),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: items[index]['color'].withOpacity(0.15),
                    child: Icon(
                      items[index]['icon'],
                      color: items[index]['color'],
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    items[index]['title'],
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // واجهة بنر العروض والتخفيضات الأنيق في نهاية الصفحة
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.deepOrange, Colors.orangeAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'خصم يصل إلى 50%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'على طلبك الأول من قسم المطاعم 🎉',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => print('فتح تفاصيل العرض الإعلاني'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'اطلب الآن',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
