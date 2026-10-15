import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlyai/features/driver_dashboard/bloc/driver_auth_bloc.dart';
import 'package:hatlyai/features/driver_dashboard/bloc/driver_auth_event.dart';
import 'package:hatlyai/features/driver_dashboard/bloc/driver_auth_state.dart';

import '../auth/presentation/driver/driver_verify_page.dart';

class DriverLoginPage extends StatefulWidget {
  const DriverLoginPage({super.key});

  @override
  State<DriverLoginPage> createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // يتبع في الجزء الثاني كود الـ body وربط الـ BlocConsumer وحركات الانتقال...
      body: SafeArea(
        child: BlocConsumer<DriverAuthBloc, DriverAuthState>(
          listener: (context, state) {
            // 1. مراقبة حالة نجاح إرسال الرمز ونقل الكابتن تلقائياً لشاشة التحقق
            if (state is SendDriverOtpSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم إرسال رمز التحقق (OTP) إلى هاتفك بنجاح! 📱✨',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DriverVerifyPage(phoneNumber: _phoneController.text),
                ),
              );
            }
            // 2. مراقبة حالة حدوث خطأ أثناء الاتصال وعرض تنبيه أحمر
            else if (state is DriverAuthFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is DriverAuthLoadingState;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.phone_android_rounded,
                      size: 72,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'تسجيل دخول الكابتن',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'أدخل رقم هاتفك لتوثيق الحساب وبدء استقبال الطلبات الحرة في محيط ٣٠ كم',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.5,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 40),

                    // حقل إدخال رقم الهاتف المحمي والصارم
                    const Text(
                      'رقم الهاتف المحمول:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontFamily: 'Cairo'),
                      decoration: InputDecoration(
                        hintText: 'مثال: 01009652051',
                        prefixIcon: const Icon(
                          Icons.phone_enabled_rounded,
                          color: Colors.grey,
                        ),
                        fillColor: Color(0xFFF8F9FA),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل رقم الهاتف';
                        }
                        if (value.length < 11) {
                          return 'رقم الهاتف يجب ألا يقل عن ١١ رقماً';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    // زر إرسال الرمز التفاعلي المتجاوب مع حالة الـ Bloc
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  // إطلاق حدث طلب إرسال الرمز برقم الهاتف الفعلي للكابتن
                                  context.read<DriverAuthBloc>().add(
                                    SendDriverOtpRequestedEvent(
                                      _phoneController.text,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'إرسال رمز التحقق الآن',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
