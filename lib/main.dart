// الجزء 1 من 1: كود ملف lib/main.dart المصحح هندسياً بالكامل
// تم توجيه الواجهة مباشرة إلى WelcomePage لمنع تعارض MaterialApp المزدوج في فلاتر

import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/service_locator.dart';
import 'core/welcome_page.dart'; // استيراد المسار الصحيح لصفحة الترحيب الافتراضية بمشروعك

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // استدعاء دالة تهيئة الاعتمادات التراكمية الخاصة بمشروعك
  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق توصيل الطلبات',
      debugShowCheckedModeBanner: false,

      // دمج نظام الهوية البصرية الموحد باللون البرتقالي
      theme: AppTheme.lightTheme,

      // توجيه العميل إلى صفحة الترحيب مباشرة كأول شاشة يراها العميل عند فتح التطبيق
      home: const WelcomePage(),
    );
  }
}
