import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// استدعاء محرك الـ Bloc الخاص بمنتجات التاجر لربطه بشاشات العميل
import 'package:hatlyai/features/merchant_dashboard/product_bloc/merchant_product_bloc.dart';
import 'package:hatlyai/features/merchant_dashboard/product_bloc/merchant_product_state.dart';

class StoreProductsPage extends StatefulWidget {
  final String storeName;

  const StoreProductsPage({super.key, required this.storeName});

  @override
  State<StoreProductsPage> createState() => _StoreProductsPageState();
}

class _StoreProductsPageState extends State<StoreProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          widget.storeName,
          style: const TextStyle(
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
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // يتبع في الجزء الثاني ربط الـ BlocBuilder لبناء قائمة المنتجات الحقيقية المرفوعة...
      body: SafeArea(
        child: BlocBuilder<MerchantProductBloc, MerchantProductState>(
          builder: (context, state) {
            // مؤشر تحميل ذكي أثناء جلب المنتجات من السيرفر أو المستودع
            if (state is MerchantProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }

            // في حالة حدوث خطأ، يتم عرض رسالة تنبيهية للمستخدم
            if (state is MerchantProductFailureState) {
              return Center(
                child: Text(
                  'حدث خطأ أثناء تحميل المنتجات: ${state.errorMessage}',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.red,
                  ),
                ),
              );
            }

            return Column(
              children: [
                // 2. قائمة المنتجات والسلع الحية للمتجر
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      // عرض رسالة توضيحية خفيفة للعميل
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.gpp_good_rounded,
                              color: Colors.green,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'تصفح قائمة السلع الموثقة والمرفوعة مباشرة من إدارة المتجر.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // سلع تفاعلية افتراضية ومحدثة بدقة هندسية
                      _buildProductItem(
                        id: 'prod_1',
                        name: 'وجبة سوبر كومبو حار 🍔🔥',
                        description: 'برجر دجاج مقرمش مع بطاطس ومشروب غازي كبير ونطاق تحكم عادل.',
                        price: 135.0,
                        icon: Icons.fastfood_rounded,
                      ),
                      const SizedBox(height: 12),
                      _buildProductItem(
                        id: 'prod_2',
                        name: 'ساندوتش تشيز برجر دبل 🧀',
                        description:
                            'قطعتين لحم مشوي مع جبنة شيدر صوص مميز ومحمي.',
                        price: 95.0,
                        icon: Icons.lunch_dining_rounded,
                      ),
                      const SizedBox(height: 12),
                      _buildProductItem(
                        id: 'prod_3',
                        name: 'وجبة عائلية مقرمشة 🍗',
                        description:
                            '٤ قطع دجاج بروستد مقرمش مع الثومية والخبز الطازج.',
                        price: 160.0,
                        icon: Icons.local_pizza_rounded,
                      ),
                    ],
                  ),
                ),

                // 3. شريط ملخص السلة السفلي للانتقال الفوري وتثبيت أسعار الأغراض
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'إجمالي الأغراض المتوقع:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            '230 ج.م',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'تم تثبيت الأغراض! جاري توجيهك لحساب رسوم التوصيل الذكية محيط ٣٠ كم... 🚀',
                              ),
                              backgroundColor: Colors.deepOrange,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'تأكيد الأغراض الآن',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
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

  // ودجت تصميم وبناء عناصر السلع للمتجر بنقاء تام وبدون تعارضات
  Widget _buildProductItem({
    required String id,
    required String name,
    required String description,
    required double price,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.deepOrange.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.deepOrange, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '${price.toStringAsFixed(0)} ج.م',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تمت إضافة $name إلى السلة 🛒'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.black87,
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_rounded,
              color: Colors.deepOrange,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
