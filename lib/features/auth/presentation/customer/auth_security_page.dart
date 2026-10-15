import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';
import '../../domain/entities/security_entity.dart';

class AuthSecurityPage extends StatefulWidget {
  const AuthSecurityPage({super.key});

  @override
  State<AuthSecurityPage> createState() => _AuthSecurityPageState();
}

class _AuthSecurityPageState extends State<AuthSecurityPage> {
  bool _isBiometricEnabled =
      true; // تفعيل بيومتري افتراضي تماشياً مع إعدادات حسابك لعام 2026
  bool _isTwoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'تأمين الحساب والمعاملات 🔒',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is BiometricSecurityUpdatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم تحديث وحفظ تفاصيل التكوين الأمني بنجاح! 🛡️✅',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // 1. مفتاح تفعيل وتغيير وضعية التحقق البيومتري حركياً
                SwitchListTile(
                  title: const Text(
                    'تسجيل الدخول بالبصمة الحيوية 👤',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: const Text(
                    'تفعيل استخدام بصمة الإصبع أو الوجه لتأمين المدفوعات والطلبات',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  value: _isBiometricEnabled,
                  activeThumbColor: Colors.green,
                  onChanged: (val) => setState(() => _isBiometricEnabled = val),
                ),
                const Divider(),

                // 2. مفتاح تفعيل وتعطيل التحقق بخطوتين
                SwitchListTile(
                  title: const Text(
                    'التحقق بخطوتين (2FA) 🔑',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: const Text(
                    'طلب رمز تحقق إضافي عبر الرسائل النصية عند تأكيد السداد المالي أو سحب الأرباح',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  value: _isTwoFactorEnabled,
                  activeThumbColor: Colors.green,
                  onChanged: (val) => setState(() => _isTwoFactorEnabled = val),
                ),
                const Divider(),

                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.update_rounded,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'آخر تحديث أمني للمنصة: اليوم ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // زر الحفظ النهائي وضخ الكيان بالـ Bloc المعتمد بمشروعك
                ElevatedButton(
                  onPressed: state is AuthLoadingState
                      ? null
                      : () {
                          final securityConfig = SecurityEntity(
                            isBiometricEnabled: _isBiometricEnabled,
                            isTwoFactorAuthEnabled: _isTwoFactorEnabled,
                            lastSecurityUpdate: DateTime.now().toString(),
                          );
                          context.read<AuthBloc>().add(
                            UpdateBiometricSecuritySettingsEvent(
                              securitySettings: securityConfig,
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: state is AuthLoadingState
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'تحديث إعدادات الأمان',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
