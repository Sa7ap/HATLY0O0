import 'dart:ui'; // مكتبة النظام الضرورية لتفعيل تأثيرات التغبيش البصري (ImageFilter)

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PersistentCartBar extends StatelessWidget {
  final int totalItems;
  final double totalPrice;
  final VoidCallback onTap;

  const PersistentCartBar({
    super.key,
    required this.totalItems,
    required this.totalPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // تجنب ظهور الشريط إذا كانت السلة فارغة تماماً لضمان نظافة الواجهة
    if (totalItems == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: AppTheme.primaryOrange.withValues(
              alpha: 0.85,
            ), // برتقالي مدمج بشفافية أنيقة للهوية
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6), // ظل سفلي ناعم يعطي إيحاء بالارتفاع
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // الحل البديل والمستقر: استخدام BackdropFilter الرسمي لعمل الخلفية الزجاجية
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.white.withValues(
                        alpha: 0.05,
                      ), // طبقة إضافية خفيفة لتعزيز المظهر الزجاجي
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // عرض عدد العناصر الإجمالي داخل دائرة بيضاء مميزة
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$totalItems',
                              style: const TextStyle(
                                color: AppTheme.primaryOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'عرض سلة المشتريات',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      // عرض السعر الإجمالي للطلب بالعملة المحلية
                      Text(
                        '${totalPrice.toStringAsFixed(2)} ج.م',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
