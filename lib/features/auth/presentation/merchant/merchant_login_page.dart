import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/merchant_auth_bloc.dart';
import 'bloc/merchant_auth_event.dart';
import 'bloc/merchant_auth_state.dart';
import 'merchant_verify_page.dart';

class MerchantLoginPage extends StatefulWidget {
  const MerchantLoginPage({super.key});

  @override
  State<MerchantLoginPage> createState() => _MerchantLoginPageState();
}

class _MerchantLoginPageState extends State<MerchantLoginPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<MerchantAuthBloc, MerchantAuthState>(
          // الـ Listener لمراقبة النجاح والتوجيه البرمجي السريع
          listener: (context, state) {
            if (state is SendMerchantOtpSuccessState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MerchantVerifyPage(phoneNumber: _phoneController.text),
                ),
              );
            } else if (state is MerchantAuthFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          // الـ Builder لإعادة رسم الواجهة حركياً بناءً على الحالات
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.storefront_rounded,
                          size: 48,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'بوابة التجار والشركاء',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'سجل دخولك برقم الهاتف المعتمد لإدارة متجرك ومتابعة طلباتك الواردة.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 40),

                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        labelText: 'رقم هاتف المتجر',
                        hintText: '01xxxxxxxxx',
                        prefixIcon: const Icon(
                          Icons.phone_android_rounded,
                          color: Colors.blueAccent,
                        ),
                        filled: true,
                        fillColor: Colors.grey.withValues(alpha: 0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال رقم الهاتف';
                        }
                        if (value.length < 10) return 'رقم الهاتف غير صحيح';
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state is MerchantAuthLoadingState
                            ? null // تعطيل الزر لمنع النقرات المتكررة أثناء الاتصال
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  // إطلاق حدث طلب الـ OTP للتاجر وإرسال رقم الهاتف
                                  context.read<MerchantAuthBloc>().add(
                                    SendMerchantOtpRequestedEvent(
                                      _phoneController.text,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 0,
                        ),
                        child: state is MerchantAuthLoadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'إرسال رمز التحقق',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
