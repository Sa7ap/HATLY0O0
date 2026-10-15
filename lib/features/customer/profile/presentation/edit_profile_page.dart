import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../customer_orders/presentation/bloc/customer_order_bloc.dart';
import '../../customer_orders/presentation/bloc/customer_order_event.dart';
import '../../customer_orders/presentation/bloc/customer_order_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(
    text: 'عمرو عبد الحكيم عباس محمد',
  ); // الاسم القانوني الفعلي
  final _phoneController = TextEditingController(text: '01000000000');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'تعديل بيانات الحساب ⚙️',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 15,
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
      // يتبع مباشرة وتلقائياً الجزء 2 من 2 لبناء حقول المدخلات وتفعيل الـ BlocConsumer...
      body: SafeArea(
        child: BlocConsumer<CustomerOrderBloc, CustomerOrderState>(
          listener: (context, state) {
            // الاستماع لحالة نجاح الحفظ بالسيرفر لإطلاق رسالة النجاح والعودة للملف الشخصي
            if (state is UpdateCustomerProfileSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تحديث بيانات ملفك الشخصي بنجاح! 👤✨'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is CustomerOrderFailureState) {
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
                padding: const EdgeInsets.all(20),
                children: [
                  // 1. حقل إدخال وتعديل الاسم الشخصي القانوني للعميل
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(fontSize: 13, fontFamily: 'Cairo'),
                    decoration: const InputDecoration(
                      labelText: 'الاسم الكامل',
                      labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                      prefixIcon: Icon(Icons.person_outline_rounded, size: 20),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (v) =>
                        v!.trim().isEmpty ? 'يرجى كتابة الاسم بالكامل' : null,
                  ),
                  const SizedBox(height: 16),

                  // 2. حقل إدخال وتعديل رقم الهاتف الخلوي الموثق
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 13, fontFamily: 'Cairo'),
                    decoration: const InputDecoration(
                      labelText: 'رقم الهاتف',
                      labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                      prefixIcon: Icon(Icons.phone_android_rounded, size: 20),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (v) {
                      if (v!.trim().isEmpty) return 'يرجى كتابة رقم الهاتف';
                      if (v.trim().length < 11) {
                        return 'رقم الهاتف يجب ألا يقل عن ١١ رقماً';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 36),

                  // زر التثبيت وحفظ التعديلات الجديدة الحية
                  ElevatedButton(
                    onPressed: state is CustomerOrderLoadingState
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<CustomerOrderBloc>().add(
                                UpdateCustomerProfileEvent(
                                  name: _nameController.text.trim(),
                                  phone: _phoneController.text.trim(),
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
                    child: state is CustomerOrderLoadingState
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'حفظ التعديلات الحالية',
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
