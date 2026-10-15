// الجزء 1 من 1: كود ملف lib/main_merchant.dart
// إدراج الهوية البرتقالية لتطبيق التاجر لضمان التناسق البصري الكامل.

import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/welcome_page.dart';

void main() {
  runApp(const MainMerchantApp());
}

class MainMerchantApp extends StatelessWidget {
  const MainMerchantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق التاجر',
      debugShowCheckedModeBanner: false,

      // تطبيق نظام الهوية البصرية البرتقالية
      theme: AppTheme.lightTheme,

      home: const WelcomePage(),
    );
  }
}
