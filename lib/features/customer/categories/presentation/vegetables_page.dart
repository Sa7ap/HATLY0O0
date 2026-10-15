import 'package:flutter/material.dart';

import '../../customer_orders/presentation/cart_page.dart';
import '../../../../core/shared_widgets/persistent_cart_bar.dart'; // استدعاء الشريط العائم الموحد
import 'product_detail_page.dart';

class VegetablesPage extends StatelessWidget {
  const VegetablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mockItems = [
      {
        'name': 'طماطم بلدي طازجة ١ كجم 🍅',
        'price': 25.0,
        'desc': 'طماطم ناضجة ومستزرعة محلياً، منتقاة بعناية فائقة لتصلك طازجة ومثالية للطهي.',
      },
      {
        'name': 'موز بلدي فاخر ١ كجم 🍌',
        'price': 35.0,
        'desc': 'موز طازج ذو نكهة غنية وحلاوة طبيعية، غني بالبوتاسيوم ومثالي كوجبة خفيفة.',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'الخضروات والفواكه 🍏',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 15,
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
      // حقن شريط السلة السفلي المستمر
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockItems.length,
        itemBuilder: (context, index) {
          final item = mockItems[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      productName: item['name'],
                      productPrice: item['price'],
                      productDescription: item['desc'],
                    ),
                  ),
                );
              },
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
              title: Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              subtitle: Text(
                '${item['price'].toStringAsFixed(0)} ج.م',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  fontFamily: 'Cairo',
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
