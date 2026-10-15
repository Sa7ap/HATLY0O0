// الجزء 1 من 2: ملف lib/features/customer/categories/presentation/supermarket_page.dart
// معالجة مشكلة السطر 49 بتغذية شريط السلة بالمعطيات المطلوبة متكاملاً مع الهوية البرتقالية

import 'package:flutter/material.dart';
import 'package:hatlyai/core/shared_widgets/persistent_cart_bar.dart'; // استدعاء مسار البار المطلق المستقر

import '../../customer_orders/presentation/cart_page.dart'; // مسار صفحة السلة بمشروعك
import 'product_detail_page.dart'; // مسار صفحة تفاصيل المنتج بمشروعك

class SupermarketPage extends StatelessWidget {
  const SupermarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('السوبرماركت والمواد الغذائية'),
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

      // الحل الهندسي: تغذية شريط السلة العائم بالمعطيات الثلاثة ليزول الخط الأحمر فوراً
      bottomNavigationBar: PersistentCartBar(
        totalItems: 4, // سيتم ربطها لاحقاً بعدد عناصر السلة الفعلي ديناميكياً
        totalPrice: 185.50, // سيتم ربطها لاحقاً بإجمالي حساب السلة الفعلي
        onTap: () {
          // التوجيه السلس لفتح شاشة السلة عند ضغط العميل على البار
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
      ),

      // هنا سنبدأ في سرد قائمة المنتجات الغذائية وسنرسلها في الجزء الثاني لإغلاق الملف بنجاح
      // الجزء 2 من 2: ملف lib/features/customer/categories/presentation/supermarket_page.dart
      // استكمال قائمة السلع الغذائية وتمرير معطيات تفاصيل المنتج الثلاثة بدقة هندسية لإزالة خطأ السطر 65
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8, // عدد السلع الافتراضية لعرض القائمة بشكل منسق بصرياً
        itemBuilder: (context, index) {
          // تعريف بيانات السلعة الغذائية الحالية لتمريرها ديناميكياً للواجهة التالية
          final String currentItemName = 'منتج غذائي عالي الجودة ${index + 1}';
          const double currentItemPrice = 35.50;
          const String currentItemDesc =
              'سلعة غذائية طازجة ومضمونة الجودة، معبأة ومغلفة بعناية فائقة وفقاً لأعلى معايير السلامة والصحة';

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
                  Icons.shopping_basket_rounded, // أيقونة السوبرماركت والمواد الغذائية
                  color: Color(0xFFFF6F00), // البرتقالي الأساسي للهوية
                  size: 28,
                ),
              ),
              title: Text(
                currentItemName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'Cairo',
                ),
              ),
              subtitle: const Text(
                'اضغط لعرض تفاصيل الوزن، تاريخ الإنتاج، وإضافته مباشرة إلى سلة التسوق',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontFamily: 'Cairo'),
              ),
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$currentItemPrice ج.م',
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
                      productName: currentItemName,
                      productPrice: currentItemPrice,
                      productDescription: currentItemDesc,
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
