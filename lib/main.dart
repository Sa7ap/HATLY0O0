import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/service_locator.dart';
import 'core/welcome_page.dart';
import 'firebase_options.dart';

// استيراد جميع الـ Blocs الخاصة بمشروعك
import 'package:hatlyai/features/auth/presentation/customer/bloc/auth_bloc.dart';
import 'package:hatlyai/features/auth/presentation/driver/bloc/driver_auth_bloc.dart';
import 'package:hatlyai/features/auth/presentation/merchant/bloc/merchant_auth_bloc.dart';
import 'package:hatlyai/features/customer/customer_orders/presentation/bloc/customer_order_bloc.dart'; // استيراد bloc الطلبات
import 'package:hatlyai/features/customer/wallet/presentation/bloc/wallet_bloc.dart'; // استيراد bloc المحفظة

void main() async {
  // التأكد من تهيئة كل أدوات الفلاتر قبل تشغيل الكود
  WidgetsFlutterBinding.ensureInitialized();

  // استدعاء دالة الحقن لتهيئة SharedPreferences وباقي الـ Blocs في الذاكرة
  await initServiceLocator();

  // تفعيل الاتصال بـ Firebase بناءً على ملف الإعدادات اليدوي الذي أنشأناه
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
        BlocProvider<DriverAuthBloc>(create: (context) => sl<DriverAuthBloc>()),
        BlocProvider<MerchantAuthBloc>(
          create: (context) => sl<MerchantAuthBloc>(),
        ),
        BlocProvider<CustomerOrderBloc>(
          create: (context) =>
              sl<CustomerOrderBloc>(), // توفير bloc الطلبات للشاشات
        ),
        BlocProvider<WalletBloc>(
          create: (context) => sl<WalletBloc>(), // توفير bloc المحفظة للشاشات
        ),
      ],
      child: MaterialApp(
        title: 'تطبيق توصيل الطلبات',
        debugShowCheckedModeBanner: false,

        // دمج نظام الهوية البصرية الموحد باللون البرتقالي الخاص بمشروعك
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
        ),

        // التوجه مباشرة إلى صفحة الترحيب المخصصة في مشروعك
        home: const WelcomePage(),
      ),
    );
  }
}
