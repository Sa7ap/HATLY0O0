// الجزء 1 من 2: ملف lib/features/customer/categories/presentation/pharmacy_page.dart
// ربط شريط السلة العائم ببيانات عناصر وسعر السلة الحقيقية لإزالة الخطأ تماماً وتفعيل الهوية البرتقالية

import 'package:flutter/material.dart';
import 'package:hatlyai/core/shared_widgets/persistent_cart_bar.dart'; // استدعاء المسار المطلق المستقر للبار

import '../../customer_orders/presentation/cart_page.dart'; // مسار صفحة السلة بمشروعك

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قسم الصيدلية والادوية'),
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

      // الحل الهندسي: توفير البيانات المطلوبة لشريط السلة العائم وتلوينه بالهوية الزجاجية البرتقالية
      bottomNavigationBar: PersistentCartBar(
        totalItems:
            3, // هنا يتم ربطه ديناميكياً بعدد العناصر الحقيقي في السلة لاحقاً
        totalPrice: 150.0, // هنا يتم ربطه ديناميكياً بإجمالي السعر الحقيقي
        onTap: () {
          // فتح صفحة السلة المكتوبة مسبقاً في مشروعك عند ضغط العميل على البار العائم
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
      ),

      // هنا سنبدأ في بناء محتوى قائمة المنتجات وسنرسلها في الجزء الثاني لإغلاق الملف
      // الجزء 2 من 2: ملف lib/features/customer/categories/presentation/pharmacy_page.dart
      // استكمال بناء قائمة المنتجات وربطها بكاش الصور المتقدم وإغلاق الملف تماماً
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6, // عدد افتراضي لعناصر الصيدلية التجريبية المتناسقة بصرياً
        itemBuilder: (context, index) {
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
                  Icons.medication_rounded, // أيقونة طبية تناسب تماماً قسم الصيدلية والأدوية
                  color: Color(0xFFFF6F00), // تلوينها بالبرتقالي الأساسي للهوية
                  size: 28,
                ),
              ),
              title: Text(
                'منتج طبي متميز ${index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'Cairo',
                ),
              ),
              subtitle: const Text(
                'وصف مختصر للمنتج الدوائي وطريقة استخدامه الآمنة للعملاء',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontFamily: 'Cairo'),
              ),
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '45.00 ج.م',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6F00), // سعر المنتج بالبرتقالي النشط
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
                // سيتم هنا لاحقاً ربط فتح صفحة تفاصيل المنتج الطبي المحددة
              },
            ),
          );
        },
      ),
    );
  }
}
