// الجزء 1 من 2: ملف lib/features/auth/presentation/driver/driver_home_page.dart
// بناء الهيكل الأساسي لشاشة السائق بالوضع الداكن المريح والموفر لطاقة بطارية الجوال

import 'package:flutter/material.dart';
import 'package:hatlyai/core/theme/app_theme.dart'; // استدعاء المسار المطلق المستقر للثيم

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  bool _isOnline =
      true; // حالة الاتصال الافتراضية للكابتن لاستقبال الطلبات الحية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استخدام اللون الداكن المريح بدلاً من الخلفية البيضاء التقليدية لشاشات الكباتن
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'لوحة تحكم الكابتن',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E1E1E), // لون شريط علوي داكن ومتناسق
        elevation: 0,
        actions: [
          // مفتاح تحويل الحالة الحية للكابتن (متصل / غير متصل)
          Switch(
            value: _isOnline,
            activeThumbColor: AppTheme.primaryOrange,
            onChanged: (value) {
              setState(() {
                _isOnline = value;
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // كارت مخصص لعرض المحفظة والأرباح الحالية للكابتن بالوضع الداكن
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رصيد المحفظة الحالي',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '350.00 ج.م',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryOrange.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppTheme.primaryOrange,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'طلبات التوصيل المتاحة بالقرب منك',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 16),

          // الجزء 2 من 2: ملف lib/features/auth/presentation/driver/driver_home_page.dart
          // استكمال بناء كروت الطلبات المتاحة للكابتن بالوضع الداكن وإغلاق الملف بالكامل

          // كارت استعراض طلب توصيل متاح قادم من المطاعم التي قمنا ببنائها
          Card(
            color: const Color(0xFF1E1E1E),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Colors.grey.shade800),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'طلب توصيل من: مطعم كرانشي الشهير',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      Text(
                        'على بعد 1.5 كم',
                        style: TextStyle(
                          color: AppTheme.primaryOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: Color(0xFF121212)),
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.grey,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'وجهة التسليم: حي الزهور، عمارة 5، الشقة 3',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'المبلغ المستحق: 45.00 ج.م',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      // زر تفاعلي لقبول الطلب وبدء رحلة التوصيل الحية للعميل
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryOrange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // تنفيذ أحداث الـ Bloc التراكمية لقبول الطلب وإشعار العميل حياً
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'تم قبول الطلب بنجاح! توجه إلى المتجر الآن.',
                              ),
                              backgroundColor: AppTheme.primaryOrange,
                            ),
                          );
                        },
                        child: const Text(
                          'قبول الطلب',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
