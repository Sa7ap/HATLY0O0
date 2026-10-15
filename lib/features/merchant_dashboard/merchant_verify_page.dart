import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // تم إضافة مكتبة الـ Bloc هنا لحل المشكلة الأساسية // تم إضافة مكتبة الـ Bloc هنا لحل المشكلة الأساسية

import 'bloc/merchant_auth_bloc.dart';
import 'bloc/merchant_auth_event.dart';
import 'bloc/merchant_auth_state.dart';
import '../auth/presentation/merchant/merchant_home_page.dart';

class MerchantVerifyPage extends StatefulWidget {
  final String phoneNumber;
  const MerchantVerifyPage({super.key, required this.phoneNumber});

  @override
  State<MerchantVerifyPage> createState() => _MerchantVerifyPageState();
}

class _MerchantVerifyPageState extends State<MerchantVerifyPage> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        child: BlocConsumer<MerchantAuthBloc, MerchantAuthState>(
          listener: (context, state) {
            if (state is VerifyMerchantOtpSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تسجيل دخول التاجر بنجاح! 🎉'),
                  backgroundColor: Colors.green,
                ),
              );

              // تفعيل التوجيه الفوري لشاشة التاجر الرئيسية الأصلية وتطهير الـ Stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MerchantHomePage(),
                ),
                (route) => false,
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
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_user_rounded,
                          size: 48,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'تأكيد رقم الشريك',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          height: 1.4,
                          fontFamily: 'Cairo',
                        ),
                        children: [
                          const TextSpan(
                            text: 'أدخل الرمز المرسل إلى هاتف المتجر: ',
                          ),
                          TextSpan(
                            text: widget.phoneNumber,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 6,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 12,
                      ),
                      decoration: InputDecoration(
                        hintText: '000000',
                        hintStyle: TextStyle(
                          color: Colors.grey.withValues(alpha: 0.3),
                          letterSpacing: 12,
                        ),
                        counterText: '',
                        filled: true,
                        fillColor: Colors.grey.withValues(alpha: 0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال رمز التحقق';
                        }
                        if (value.length < 6) {
                          return 'يجب إدخال الـ 6 أرقام كاملة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state is MerchantAuthLoadingState
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<MerchantAuthBloc>().add(
                                    VerifyMerchantOtpRequestedEvent(
                                      phoneNumber: widget.phoneNumber,
                                      otp: _otpController.text,
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
                                'تأكيد ومتابعة',
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
