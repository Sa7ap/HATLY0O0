import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlyai/features/auth/presentation/driver/bloc/driver_auth_bloc.dart';
import 'package:hatlyai/features/auth/presentation/driver/bloc/driver_auth_event.dart';
import 'package:hatlyai/features/auth/presentation/driver/bloc/driver_auth_state.dart';

import 'driver_home_page.dart';

class DriverVerifyPage extends StatefulWidget {
  final String phoneNumber;

  const DriverVerifyPage({super.key, required this.phoneNumber});

  @override
  State<DriverVerifyPage> createState() => _DriverVerifyPageState();
}

class _DriverVerifyPageState extends State<DriverVerifyPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
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
      // يتبع في الجزء الثاني كود الـ body وربط الـ BlocConsumer لمطابقة الرمز حركياً...
      body: SafeArea(
        child: BlocConsumer<DriverAuthBloc, DriverAuthState>(
          listener: (context, state) {
            // 1. مراقبة حالة نجاح توثيق الحساب بالرمز الصحيح (تأكد من مطابقة اسم الحالة الفعلي في ملفاتك)
            if (state is VerifyDriverOtpSuccessState ||
                state is VerifyDriverOtpSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم توثيق وتأكيد حسابك بنجاح! مرحباً بك يا كابتن 🎉🏁',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              // الانتقال الحاسم وإغلاق شاشات تسجيل الدخول السابقة للتوجه للوحة التحكم المستقرة
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const DriverHomePage()),
                (route) => false,
              );
            }
            // 2. مراقبة حالة حدوث خطأ في الرمز أو الاتصال وعرض تنبيه أحمر
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
                      Icons.verified_user_rounded,
                      size: 72,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'رمز التحقق من الهوية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'أدخل الرمز المرسل في رسالة نصية إلى الرقم:\n${widget.phoneNumber}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.5,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 40),

                    // حقل إدخال كود الـ OTP الرقمي الصارم
                    const Text(
                      'أدخل رمز التحقق (OTP):',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        letterSpacing: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '••••••',
                        hintStyle: const TextStyle(letterSpacing: 4),
                        fillColor: const Color(0xFFF8F9FA),
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
                          return 'من فضلك أدخل رمز التحقق';
                        }
                        if (value.length < 4) {
                          return 'الرمز لا يمكن أن يقل عن ٤ أرقام';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    // زر التأكيد النهائي المتجاوب حركياً مع الـ Bloc
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  // إطلاق حدث تأكيد الرمز الموضح والمطابق لملفاتك مع مراعاة الـ Positional Parameters
                                  context.read<DriverAuthBloc>().add(
                                    VerifyDriverOtpRequestedEvent(
                                      phoneNumber: widget.phoneNumber,
                                      otp: _codeController.text,
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
                                'تأكيد الدخول الآن',
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
