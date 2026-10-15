import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../customer_orders/presentation/bloc/customer_order_bloc.dart';
import '../../customer_orders/presentation/bloc/customer_order_event.dart';
import '../../customer_orders/presentation/bloc/customer_order_state.dart';
import '../../customer_orders/domain/entities/address_entity.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'إضافة عنوان 🏠',
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
      // يتبع مباشرة الجزء 2 من 2 لحقل الاستهلاك وضخ البيانات الحية...
      body: SafeArea(
        child: BlocConsumer<CustomerOrderBloc, CustomerOrderState>(
          listener: (context, state) {
            if (state is SaveNewAddressSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم حفظ العنوان الجغرافي بنجاح! 📍🏠'),
                  backgroundColor: Colors.green,
                ),
              );
              // إطلاق حدث إعادة جلب قائمة العناوين لتحديث الشاشة السابقة تلقائياً
              context.read<CustomerOrderBloc>().add(GetSavedAddressesEvent());
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
                  // 1. حقل إدخال اسم وتسمية العنوان المسجل
                  TextFormField(
                    controller: _titleController,
                    style: const TextStyle(fontSize: 13, fontFamily: 'Cairo'),
                    decoration: const InputDecoration(
                      labelText: 'اسم العنوان (مثال: المنزل، العمل)',
                      labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (v) => v!.trim().isEmpty
                        ? 'يرجى كتابة اسم وتسمية العنوان'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // 2. حقل إدخال اسم المدينة أو المركز
                  TextFormField(
                    controller: _cityController,
                    style: const TextStyle(fontSize: 13, fontFamily: 'Cairo'),
                    decoration: const InputDecoration(
                      labelText: 'المدينة / المركز (مثال: سمنود)',
                      labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (v) =>
                        v!.trim().isEmpty ? 'يرجى كتابة اسم المدينة' : null,
                  ),
                  const SizedBox(height: 16),

                  // 3. حقل إدخال تفاصيل العنوان التفصيلية للمندوب
                  TextFormField(
                    controller: _addressController,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 13, fontFamily: 'Cairo'),
                    decoration: const InputDecoration(
                      labelText: 'تفاصيل العنوان الكاملة (الشارع، معالم مميزة)',
                      labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (v) =>
                        v!.trim().isEmpty ? 'يرجى كتابة تفاصيل العنوان' : null,
                  ),
                  const SizedBox(height: 32),

                  // زر الحفظ والإرسال المباشر التفاعلي
                  ElevatedButton(
                    onPressed: state is CustomerOrderLoadingState
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              final newAddr = AddressEntity(
                                id: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                title: _titleController.text.trim(),
                                fullAddress: _addressController.text.trim(),
                                city: _cityController.text.trim(),
                                latitude: 30.9575, // محاكاة إحداثيات سمنود المعتمدة بمشروعك
                                longitude: 31.2594,
                              );
                              context.read<CustomerOrderBloc>().add(
                                SaveNewAddressEvent(address: newAddr),
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
                            'تثبيت وحفظ العنوان الجغرافي',
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
