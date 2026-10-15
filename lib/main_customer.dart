// الجزء 1 من 1: كود ملف lib/main_driver.dart
// تعديل الواجهة لتعمل بنظام الألوان الموحد الخاص بالهوية.

import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/welcome_page.dart'; // ربطه بصفحة الترحيب الافتراضية للنظام

void main() {
  runApp(const MainDriverApp());
}

class MainDriverApp extends StatelessWidget {
  const MainDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق السائق',
      debugShowCheckedModeBanner: false,

      // تطبيق نظام الهوية البصرية البرتقالية
      theme: AppTheme.lightTheme,

      home: const WelcomePage(),
    );
  }
}
