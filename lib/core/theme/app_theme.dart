// الجزء 1 من 1: ملف lib/core/theme/app_theme.dart
// تم إنشاء هذا الملف بالكامل لتعريف نظام الألوان البرتقالية وتوحيد عناصر الواجهة.

import 'package:flutter/material.dart';

class AppTheme {
  // تعريف لوحة الألوان البرتقالية المخصصة للهوية البصرية
  static const Color primaryOrange = Color(
    0xFFFF6F00,
  ); // البرتقالي النشط والأساسي للعمليات الرئيسية
  static const Color lightOrange = Color(
    0xFFFFF3E0,
  ); // برتقالي فاتح جداً للخلفيات المصغرة والـ Badges
  static const Color darkOrange = Color(
    0xFFE65100,
  ); // برتقالي داكن لحالات الضغط والتأكيد والتنبيهات
  static const Color backgroundLight = Color(
    0xFFF9F9F9,
  ); // خلفية التطبيق النظيفة والمريحة للعين
  static const Color textDark = Color(
    0xFF212121,
  ); // لون النصوص الأساسية لضمان وضوح القراءة
  static const Color textLight = Color(
    0xFF757575,
  ); // لون النصوص الثانوية والتوضيحية
  static const Color borderGrey = Color(
    0xFFE0E0E0,
  ); // لون الحدود الافتراضية للحقول والبطاقات

  // بناء الثيم المضيء الموحد للتطبيق
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryOrange,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: primaryOrange,
        secondary: darkOrange,
        surface: Colors.white,
        error: Colors.redAccent,
      ),

      // تخصيص الهوية البصرية لجميع الأزرار المرتفعة (Elevated Buttons)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo', // مهيأ لدعم الخطوط العربية الاحترافية
          ),
        ),
      ),

      // تخصيce الهوية البصرية لأزرار النصوص (Text Buttons)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryOrange,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
        ),
      ),

      // تخصيص الهوية البصرية لحقول الإدخال النصية (TextFields / InputDeco)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryOrange, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        labelStyle: const TextStyle(color: textLight, fontFamily: 'Cairo'),
        hintStyle: const TextStyle(
          color: textLight,
          fontSize: 14,
          fontFamily: 'Cairo',
        ),
      ),

      // تخصيص شريط التطبيق العلوي (AppBar)
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        iconTheme: IconThemeData(color: textDark),
      ),

      // تخصيص الخطوط العامة للنصوص داخل التطبيق
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        titleLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
        bodyLarge: TextStyle(
          color: textDark,
          fontSize: 16,
          fontFamily: 'Cairo',
        ),
        bodyMedium: TextStyle(
          color: textLight,
          fontSize: 14,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
