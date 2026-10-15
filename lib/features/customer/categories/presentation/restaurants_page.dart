// الجزء 1 من 2: ملف lib/features/customer/categories/presentation/restaurants_page.dart
// تهيئة الهيكل وشريط السلة العائم بالهوية البرتقالية الزجاجية لحل الأخطاء السابقة تماماً

import 'package:flutter/material.dart';
import 'package:hatlyai/core/shared_widgets/persistent_cart_bar.dart'; // مسار البار المطلق المستقر

import '../../customer_orders/presentation/cart_page.dart';
import 'product_detail_page.dart'; // مسار صفحة تفاصيل الوجبة بمشروعك

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المطاعم والوجبات السريعة'),
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

      // تغذية شريط السلة العائم بالمعطيات الثلاثة لضمان استقراره بصرياً وهندسياً
      bottomNavigationBar: PersistentCartBar(
        totalItems: 2,
        totalPrice: 220.0,
        onTap: () {
          // التوجيه السلس لفتح شاشة السلة عند ضغط العميل على البار
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
      ),
      // الجزء 2 من 2: ملف lib/features/customer/categories/presentation/restaurants_page.dart
      // استكمال قائمة الوجبات مع تمرير معطيات تفاصيل المنتج الثلاثة بدقة هندسية لإزالة خطأ السطر 109

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // عدد الوجبات المعروضة بشكل منسق بصرياً
        itemBuilder: (context, index) {
          // تعريف بيانات الوجبة الحالية لتمريرها ديناميكياً للواجهة التالية
          final String currentMealName = 'وجبة سوبر كرانشي متميزة ${index + 1}';
          const double currentMealPrice = 110.00;
          const String currentMealDesc =
              'دجاج مقرمش طازج مع أصابع البطاطس الذهبية، صوص الجبن الغني والمشروب البارد المختار';

          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.restaurant_menu_rounded, // أيقونة الوجبات والمطاعم
                  color: Color(0xFFFF6F00), // البرتقالي الأساسي للهوية
                  size: 28,
                ),
              ),
              title: Text(
                currentMealName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'Cairo',
                ),
              ),
              subtitle: const Text(
                'اضغط لعرض المكونات واختيار الحجم والإضافات الشهية المتاحة للوجبة',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontFamily: 'Cairo'),
              ),
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$currentMealPrice ج.م',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6F00), // السعر بالبرتقالي النشط
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Icon(
                    Icons.add_circle_rounded,
                    color: Color(0xFFFF6F00),
                    size: 24,
                  ),
                ],
              ),
              onTap: () {
                // الحل الهندسي الجذري: الانتقال مع تمرير المعطيات الثلاثة المطلوبة وحذف الـ const
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      productName: currentMealName,
                      productPrice: currentMealPrice,
                      productDescription: currentMealDesc,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
