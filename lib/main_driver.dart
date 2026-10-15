// lib/main_driver.dart
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DriverApp());
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هاتلي - كابتن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:
            Colors.blue, // ثيم مخصص ومختلف للمندوب لضمان الفصل البصري
        fontFamily: 'Cairo',
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'واجهة كابتن توصيل هاتلي 🚗\nجاري تهيئة لوحة التحكم والخرائط الحية...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
