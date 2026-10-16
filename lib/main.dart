import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/welcome_page.dart';
import 'firebase_options.dart';

// هذا هو المسار الفعلي والبرمجي الصحيح للملف

void main() async {
  // التأكد من تهيئة كل أدوات الفلاتر قبل تشغيل الكود
  WidgetsFlutterBinding.ensureInitialized();

  // تفعيل الاتصال بـ Firebase بناءً على ملف الإعدادات اليدوي الذي أنشأناه
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق توصيل الطلبات',
      debugShowCheckedModeBanner: false,

      // دمج نظام الهوية البصرية الموحد باللون البرتقالي الخاص بمشروعك
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),

      // التوجه مباشرة إلى صفحة الترحيب المخصصة في مشروعك
      home: const WelcomePage(),
    );
  }
}
