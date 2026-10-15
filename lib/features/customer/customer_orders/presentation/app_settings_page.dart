import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/customer_order_bloc.dart';
import 'bloc/customer_order_event.dart';
import 'bloc/customer_order_state.dart';
import '../domain/entities/settings_entity.dart';
import '../../../auth/presentation/customer/auth_security_page.dart'; // استدعاء شاشة الأمان الجديدة هنا

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _isDark = false;
  String _lang = 'ar';
  bool _isNotifOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'إعدادات التطبيق ⚙️',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isDark ? Colors.white : Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        backgroundColor: _isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: _isDark ? Colors.white : Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<CustomerOrderBloc, CustomerOrderState>(
        listener: (context, state) {
          if (state is AppSettingsUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم حفظ وتحديث تفاصيل التكوين بنجاح! ⚙️✅'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SwitchListTile(
              title: Text(
                'الوضع المظلم (Dark Mode) 🌙',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _isDark ? Colors.white : Colors.black87,
                ),
              ),
              subtitle: const Text(
                'تغيير مظهر المنصة لحماية العين وترشيد استهلاك الطاقة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              value: _isDark,
              activeThumbColor: Colors.green,
              onChanged: (val) => setState(() => _isDark = val),
            ),
            const Divider(),

            SwitchListTile(
              title: Text(
                'نغمات التنبيهات الفورية 🔔',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _isDark ? Colors.white : Colors.black87,
                ),
              ),
              subtitle: const Text(
                'تشغيل الإشعارات الحية لمتابعة مراحل ططهي وتوصيل الطلب حر',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              value: _isNotifOn,
              activeThumbColor: Colors.green,
              onChanged: (val) => setState(() => _isNotifOn = val),
            ),
            const Divider(),

            ListTile(
              title: Text(
                'لغة التطبيق الافتراضية 🌐',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _isDark ? Colors.white : Colors.black87,
                ),
              ),
              subtitle: Text(
                _lang == 'ar' ? 'العربية' : 'English',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              trailing: Icon(
                Icons.language_rounded,
                color: _isDark ? Colors.white : Colors.black87,
              ),
              onTap: () {
                setState(() => _lang = _lang == 'ar' ? 'en' : 'ar');
              },
            ),
            const Divider(),

            // --- الخيار الجديد المضاف: التوجيه الحركي نحو لوحة الأمان والتحقق البيومتري لعام 2026 ---
            ListTile(
              title: Text(
                'تأمين الحساب والبيانات البيومترية 🛡️',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _isDark ? Colors.white : Colors.black87,
                ),
              ),
              subtitle: const Text(
                'إدارة حماية الحساب بواسطة رموز التحقق وبصمة الوجه والإصبع',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              trailing: const Icon(Icons.security_rounded, color: Colors.green),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthSecurityPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                final settingsConfig = SettingsEntity(
                  isDarkMode: _isDark,
                  selectedLanguage: _lang,
                  isNotificationsOn: _isNotifOn,
                );
                context.read<CustomerOrderBloc>().add(
                  UpdateAppSettingsEvent(settings: settingsConfig),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'حفظ الإعدادات الحالية',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
