import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/customer_order_bloc.dart';
import 'bloc/customer_order_event.dart';
import 'bloc/customer_order_state.dart';

class OrderReceiptPage extends StatefulWidget {
  final String orderId;
  const OrderReceiptPage({super.key, required this.orderId});

  @override
  State<OrderReceiptPage> createState() => _OrderReceiptPageState();
}

class _OrderReceiptPageState extends State<OrderReceiptPage> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerOrderBloc>().add(
      GetPaymentReceiptDetailEvent(orderId: widget.orderId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'الإيصال المالي الموثق 📄',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
        builder: (context, state) {
          if (state is CustomerOrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange),
            );
          }
          if (state is GetPaymentReceiptDetailSuccessState) {
            final receipt = state.receipt;
            return ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'عملية سداد ناجحة وآمنة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'رقم المعاملة: ${receipt.transactionId}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      const Divider(height: 32),

                      // تفكيك البنود المالية الشفافة لمنع التلاعب وتوضيح مستحقات المنظومة الثلاثية
                      _buildReceiptRow(
                        'إجمالي الفاتورة المستقطعة:',
                        '${receipt.amountPaid} ج.م',
                        isBold: true,
                      ),
                      const SizedBox(height: 12),
                      _buildReceiptRow(
                        'صافي مستحقات المتجر/الصيدلية: 🧑‍🍳',
                        '${receipt.merchantShare} ج.م',
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      _buildReceiptRow(
                        'صافي حق مندوب التوصيل: 🚴',
                        '${receipt.deliveryFee} ج.م',
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 8),
                      _buildReceiptRow(
                        'رسوم تشغيل منصة هاتلي: 🚀',
                        '${receipt.platformFee} ج.م',
                        color: Colors.grey,
                      ),

                      const Divider(height: 32),
                      Text(
                        'طريقة الدفع الاقتطاعي: ${receipt.paymentMethod}',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('فشل جلب تفاصيل الإيصال المالي'));
        },
      ),
    );
  }

  Widget _buildReceiptRow(
    String title,
    String val, {
    bool isBold = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: color ?? Colors.black87,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          val,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: color ?? Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
