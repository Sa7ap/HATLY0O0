import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/service_locator.dart';
import 'utils/app_constants.dart';
import '../features/auth/presentation/customer/login_phone_page.dart';
import '../features/customer/home/presentation/home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _checkAutoLoginStatus();
  }

  // دالة فحص وتأمين العبور التلقائي للرئيسية لعام 2026 بنقاء تام
  Future<void> _checkAutoLoginStatus() async {
    await Future.delayed(
      const Duration(seconds: 2),
    ); // ترك فرصة لعرض شعار المنصة
    final prefs = sl<SharedPreferences>();
    final bool isLoggedIn =
        prefs.getBool(AppConstants.keyUserLoggedIn) ?? false;

    if (mounted) {
      if (isLoggedIn) {
        // عبور فوري تفاعلي للرئيسية إذا كان مسجلاً مسبقاً
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // التوجيه لشاشة الهاتف إن لم يكن مسجلاً
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPhonePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rocket_launch_rounded, size: 80, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'هاتلي دليفري 🚀',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'كل طلباتك الحر في سمنود تصلك بثواني',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
