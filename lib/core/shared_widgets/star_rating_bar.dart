// الجزء 1 من 1: ملف lib/core/shared_widgets/star_rating_bar.dart
// تم إضافة ميزة التفاعل والضغط التراكمي لدعم التقييم المباشر مع الحفاظ على الألوان البرتقالية للهوية

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StarRatingBar extends StatelessWidget {
  final double rating;
  final double starSize;
  final int itemCount;
  // إضافة دالة برمجية اختيارية لاستقبال تفاعل وضغطات المستخدم
  final ValueChanged<double>? onRatingChanged;

  const StarRatingBar({
    super.key,
    required this.rating,
    this.starSize = 18.0,
    this.itemCount = 5,
    this.onRatingChanged, // تم البناء الفوقي بإضافتها هنا كخاصية مرنة
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        IconData icon;
        Color iconColor;

        // حساب حالة امتلاء النجمة بناءً على الرقم الممرر
        if (index >= rating) {
          icon = Icons.star_border_rounded;
          iconColor = Colors.grey.shade400;
        } else if (index > rating - 1 && index < rating) {
          icon = Icons.star_half_rounded;
          iconColor = AppTheme.primaryOrange;
        } else {
          icon = Icons.star_rounded;
          iconColor = AppTheme.primaryOrange;
        }

        // تحويل النجمة إلى زر قابل للتفاعل فقط إذا تم تمرير دالة onRatingChanged
        return GestureDetector(
          onTap: onRatingChanged == null
              ? null
              : () => onRatingChanged!(index + 1.0),
          child: Icon(icon, color: iconColor, size: starSize),
        );
      }),
    );
  }
}
