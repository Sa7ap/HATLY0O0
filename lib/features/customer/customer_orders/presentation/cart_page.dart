import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared_widgets/empty_state_widget.dart';
import 'bloc/customer_order_bloc.dart';
import 'bloc/customer_order_state.dart';
import 'order_payment_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'سلة المشتريات الحالية 🛒',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 14,
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
      // تصحيح: قراءة حالة السلة ديناميكياً عبر الـ Bloc لمنع تنبيهات الـ Dead Code كلياً
      body: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
        builder: (context, state) {
          int cartQuantity = 0;

          if (state is CartItemQuantityUpdatedState) {
            cartQuantity = state.updatedQuantity;
          }

          // إذا كان معداد السلة صفراً، يتم إرجاع واجهة السلة الفارغة الموحدة بنقاء
          if (cartQuantity == 0) {
            return const EmptyStateWidget(
              icon: Icons.shopping_basket_rounded,
              title: 'سلة مشترياتك خالية حالياً',
              subtitle: 'تصفح أقسام المطاعم، المقاضي، والصيدلية الطازجة لتضيف كمياتك وتتحكم بمعداد السلة حياً.',
            );
          }

          // إذا احتوت السلة على منتجات، يتم عرض كرت السداد بشكل نشط وديناميكي 100%
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.shopping_cart_checkout_rounded,
                  size: 48,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                Text(
                  'لديك عدد ($cartQuantity) سلع جاهزة للتوصيل بالسلة!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderPaymentPage(
                          orderId: '2026',
                          amountToPay: 135,
                        ),
                      ),
                    );
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
                  child: const Text(
                    'الانتقال لسداد الفاتورة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
