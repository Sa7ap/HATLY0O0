import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../customer_orders/presentation/bloc/customer_order_bloc.dart';
import '../../customer_orders/presentation/bloc/customer_order_event.dart';
import '../../customer_orders/presentation/bloc/customer_order_state.dart';
import 'home_fields.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _orderController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _deliveryPriceController =
      TextEditingController();

  final double _distanceInMeters = 2000;

  @override
  void dispose() {
    _orderController.dispose();
    _storeNameController.dispose();
    _itemPriceController.dispose();
    _deliveryPriceController.dispose();
    super.dispose();
  }

  // يتبع في الجزء الثاني كود دالة الـ build وتغليف الـ BlocConsumer...
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerOrderBloc, CustomerOrderState>(
      listener: (context, state) {
        // 1. تصحيح حالة نجاح إطلاق وتأكيد الطلب الحر للعميل
        if (state is CreateOrderSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم إرسال طلبك الحر بنجاح! جاري التوصيل مع أقرب كابتن 🏁',
              ),
              backgroundColor: Colors.green,
            ),
          );
          _orderController.clear();
          _storeNameController.clear();
          _itemPriceController.clear();

          // 2. تصحيح حالة فشل إرسال الطلب وقراءة رسالة الخطأ الصارمة
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
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomerHomeFields(
                formKey: _formKey,
                orderDetailsController: _orderController,
                storeNameController: _storeNameController,
                priceController: _itemPriceController,
                deliveryFeeController: _deliveryPriceController,
                distanceInMeters: _distanceInMeters,
              ),

              const SizedBox(height: 32),

              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: state is CustomerOrderLoadingState
                      ? null
                      : () {
                          // تصحيح: التحقق الفوري وإرسال البيانات كخريطة Map متكاملة تناسب الـ Bloc
                          if (_formKey.currentState!.validate()) {
                            final orderData = {
                              'id': DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              'orderDetails': _orderController.text,
                              'storeName': _storeNameController.text.isEmpty
                                  ? "أي متجر متاح (يختاره المندوب)"
                                  : _storeNameController.text,
                              'itemsPrice':
                                  double.tryParse(_itemPriceController.text) ??
                                  0.0,
                              'deliveryFee':
                                  double.tryParse(
                                    _deliveryPriceController.text,
                                  ) ??
                                  20.0,
                              'orderStatus': 'pending',
                            };

                            // إطلاق الحدث المعتمد الحقيقي بمشروعك وتمرير الخريطة بنجاح
                            context.read<CustomerOrderBloc>().add(
                              CreateOrderRequestedEvent(orderData),
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
                  child: state is CustomerOrderLoadingState
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'اطلب الآن من المندوب',
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
        );
      },
    );
  }
}
