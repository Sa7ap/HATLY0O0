// الجزء 1 من 2: ملف lib/features/customer/customer_orders/presentation/order_payment_page.dart
// تم إضافة الاستيرادات المطلقة من أصول مشروعك ليتعرف المترجم على الأحداث والكيانات بنجاح

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlyai/core/theme/app_theme.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/entities/payment_entity.dart'; // مسار الكيان المستورد

import 'bloc/customer_order_bloc.dart';
import 'bloc/customer_order_event.dart'; // مسار ملف الأحداث المستورد
import 'bloc/customer_order_state.dart';
import 'order_tracker_view.dart';

class OrderPaymentPage extends StatefulWidget {
  final String orderId;
  final double amountToPay;

  const OrderPaymentPage({
    super.key,
    required this.orderId,
    required this.amountToPay,
  });

  @override
  State<OrderPaymentPage> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
  String _selectedPaymentMethod = 'cash'; // طريقة الدفع الافتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام عملية الدفع'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<CustomerOrderBloc, CustomerOrderState>(
        listener: (context, state) {
          if (state is ProcessOrderPaymentSuccessState ||
              state is UpdateOrderStatusSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم تأكيد عملية الدفع بنجاح! جاري تحويلك للتتبع...',
                ),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderTrackerView(orderId: widget.orderId),
              ),
            );
          } else if (state is CustomerOrderFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        child: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                // كارت عرض القيمة المالية الكلية المطلوب دفعها بالهوية البرتقالية الدافئة
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.lightOrange,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primaryOrange.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'إجمالي المبلغ المطلوب سداده',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textLight,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.amountToPay.toStringAsFixed(2)} ج.م',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'اختر طريقة الدفع المفضلة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 16),
                // الجزء 2 من 2: ملف lib/features/customer/customer_orders/presentation/order_payment_page.dart
                // بناء كروت الدفع وزر التوثيق التفاعلي مع تمرير كائن الـ PaymentEntity الإجباري بمشروعك

                // كارت خيار الدفع الأول: نقداً عند الاستلام
                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _selectedPaymentMethod == 'cash'
                          ? AppTheme.primaryOrange
                          : AppTheme.borderGrey,
                      width: _selectedPaymentMethod == 'cash' ? 1.5 : 1,
                    ),
                  ),
                  child: RadioListTile<String>(
                    title: const Text(
                      'دفع نقدي عند الاستلام',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    subtitle: const Text(
                      'سداد القيمة للكابتن فور وصول الطلب إلى باب منزلك',
                      style: TextStyle(fontSize: 12, fontFamily: 'Cairo'),
                    ),
                    value: 'cash',
                    groupValue: _selectedPaymentMethod,
                    activeColor: AppTheme.primaryOrange,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // كارت خيار الدفع الثاني: المحفظة الرقمية للتطبيق
                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _selectedPaymentMethod == 'wallet'
                          ? AppTheme.primaryOrange
                          : AppTheme.borderGrey,
                      width: _selectedPaymentMethod == 'wallet' ? 1.5 : 1,
                    ),
                  ),
                  child: RadioListTile<String>(
                    title: const Text(
                      'الدفع عن طريق المحفظة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    subtitle: const Text(
                      'اقتطاع القيمة مباشرة من رصيدك الحالي داخل التطبيق',
                      style: TextStyle(fontSize: 12, fontFamily: 'Cairo'),
                    ),
                    value: 'wallet',
                    groupValue: _selectedPaymentMethod,
                    activeColor: AppTheme.primaryOrange,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 48),

                // زر التأكيد وإرسال طلب الدفع الفوري عبر الحدث التراكمي الصحيح للـ Bloc
                ElevatedButton(
                  onPressed: state is CustomerOrderLoadingState
                      ? null
                      : () {
                          // الحل الهندسي الجذري: بناء الكيان بالأسماء الدقيقة للحقول في مشروعك
                          final paymentData = PaymentEntity(
                            transactionId: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            orderId: widget.orderId,
                            paymentMethod: _selectedPaymentMethod,
                            amountPaid: widget.amountToPay,
                            paymentStatus: 'PENDING',
                            merchantShare:
                                widget.amountToPay *
                                0.85, // حساب تلقائي تراكمي لحصة المتجر
                            deliveryFee: 0.0, // التزاماً بشرطك: لا توجد رسوم توصيل ابتدائية افتراضية
                            platformFee: 10.0, // رسوم الخدمة الثابتة للتطبيق
                          );

                          // إطلاق الحدث مع تمرير كائن الدفع المطابق لإنهاء التعارض تماماً
                          context.read<CustomerOrderBloc>().add(
                            ProcessOrderPaymentEvent(payment: paymentData),
                          );
                        },
                  child: state is CustomerOrderLoadingState
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('تأكيد الدفع والطلب'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
