import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlyai/core/theme/app_theme.dart'; // استدعاء المسار المطلق المستقر للثيم الموحد

import 'bloc/merchant_auth_bloc.dart';
import 'bloc/merchant_auth_state.dart';

class MerchantHomePage extends StatefulWidget {
  const MerchantHomePage({super.key});

  @override
  State<MerchantHomePage> createState() => _MerchantHomePageState();
}

class _MerchantHomePageState extends State<MerchantHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('لوحة تحكم المتجر'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_active_rounded,
              color: AppTheme.primaryOrange,
            ),
            onPressed: () {
              // سيتم هنا ربط مركز إشعارات التاجر لاستقبال الطلبات الجديدة فوراً
            },
          ),
        ],
      ),
      body: BlocBuilder<MerchantAuthBloc, MerchantAuthState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              // كارت علوي ذكي لعرض ملخص أداء المبيعات والطلبات اليومية للتاجر
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderGrey),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'طلبات اليوم',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textLight,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '12 طلب',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(color: AppTheme.borderGrey, thickness: 1),
                    Column(
                      children: [
                        Text(
                          'أرباح اليوم',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textLight,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '450.00 ج.م',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'الطلبات الجاري تجهيزها بالمطبخ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 16),
              // الجزء 2 من 2: ملف lib/features/auth/presentation/merchant/merchant_home_page.dart
              // استكمال بناء كروت إدارة الطلبات الجارية بأزرار تفاعلية ملونة وإغلاق الملف تماماً

              // كارت استعراض الطلب الجاري تجهيزه داخل المطبخ
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppTheme.borderGrey),
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
                            'طلب رقم #4582',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                              fontSize: 15,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            'جاري الطهي',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFB300),
                              fontSize: 13,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 24,
                        color: AppTheme.backgroundLight,
                      ),
                      const Text(
                        'العناصر: 1x وجبة سوبر كرانشي، 1x لتر كولا عائلي',
                        style: TextStyle(
                          color: AppTheme.textLight,
                          fontSize: 13,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // زر تفاعلي لتحديث وضعية تجهيز السلعة حياً بالدرجات البرتقالية النشطة
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryOrange,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () {
                              // تنفيذ أحداث الـ Bloc التراكمية لتحديث حالة المطبخ
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'تم تحديث حالة الطلب إلى: جاهز للتسليم',
                                  ),
                                  backgroundColor: AppTheme.primaryOrange,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.restaurant_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'جاهز للتسليم',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
          );
        },
      ),
    );
  }
}
