import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';
import '../../../customer/home/presentation/home_page.dart'; // استدعاء شاشة العميل الرئيسية

class CustomerVerifyOtpPage extends StatefulWidget {
  final String phoneNumber;
  const CustomerVerifyOtpPage({super.key, required this.phoneNumber});

  @override
  State<CustomerVerifyOtpPage> createState() => _CustomerVerifyOtpPageState();
}

class _CustomerVerifyOtpPageState extends State<CustomerVerifyOtpPage> {
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
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpVerifySuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم توثيق وتأكيد حسابك بنجاح! مرحباً بك 👑✨'),
                  backgroundColor: Colors.green,
                ),
              );
              // الانتقال الحاسم وإغلاق شاشات تسجيل الدخول للتوجه للرئيسية حركياً لعام 2026
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            } else if (state is AuthFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  const Icon(
                    Icons.mark_email_read_rounded,
                    size: 64,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'أدخل كود التحقق 🔑',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تم إرسال رمز التأكيد الفوري إلى الرقم:\n${widget.phoneNumber}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 36),

                  // حقل إدخال رمز الـ OTP الفوري المكون من 6 أرقام
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8,
                    ),
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      hintText: '000000',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 8,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8F9FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (v) {
                      if (v!.trim().isEmpty) return 'يرجى إدخال رمز التحقق';
                      if (v.trim().length < 6) {
                        return 'يجب إدخال الـ ٦ أرقام كاملة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),

                  // زر التأكيد النهائي التفاعلي المحمي بـ الـ Bloc
                  ElevatedButton(
                    onPressed: state is AuthLoadingState
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                VerifyOtpEvent(
                                  phoneNumber: widget.phoneNumber,
                                  otpCode: _codeController.text.trim(),
                                ),
                              );
                            }
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
                            'تأكيد الرمز والدخول',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
