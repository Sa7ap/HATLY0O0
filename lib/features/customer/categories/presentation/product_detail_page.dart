import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../customer_orders/presentation/bloc/customer_order_bloc.dart';
import '../../customer_orders/presentation/bloc/customer_order_event.dart';
import '../../customer_orders/presentation/bloc/customer_order_state.dart';
import '../../customer_orders/domain/entities/cart_item_entity.dart';

class ProductDetailPage extends StatefulWidget {
  final String productName;
  final double productPrice;
  final String productDescription;

  const ProductDetailPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1; // معداد الكمية الابتدائية للمنتج بداخل الصفحة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<CustomerOrderBloc, CustomerOrderState>(
        listener: (context, state) {
          if (state is CartItemQuantityUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'تمت إضافة ${state.updatedQuantity} من "${widget.productName}" إلى السلة بنجاح! 🛒✨',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          }
        },
        child: CustomScrollView(
          slivers: [
            // ترويسة تفاعلية حركية منزلقة مع سحب الشاشة لأعلى
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              backgroundColor: Colors.deepOrange,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: const Color(0xFFFFF3E0),
                  child: Center(
                    child: Icon(
                      Icons.fastfood_rounded,
                      color: Colors.deepOrange.withValues(alpha: 0.6),
                      size: 100,
                    ),
                  ),
                ),
              ),
            ),
            // يتبع مباشرة وتلقائياً الجزء 2 من 2 بالرد القادم...
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم المنتج وسعره الصافي الصارم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.productName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Text(
                          '${widget.productPrice.toStringAsFixed(0)} ج.م',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // الوصف والتحضير والمكونات الغذائية للسلعة
                    const Text(
                      'المكونات والتفاصيل:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.productDescription,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'Cairo',
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // لوحة التعداد الحركي والتحكم بزيادة ونقصان الكمية المطلوبة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'الكمية المطلوبة:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.black87,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline_rounded,
                                  color: Colors.grey,
                                ),
                                onPressed: _quantity > 1
                                    ? () => setState(() => _quantity--)
                                    : null,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  '$_quantity',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () => setState(() => _quantity++),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),

                    // زر التأكيد النهائي وضخ وحقن الكيان بداخل السلة الحية حركياً
                    ElevatedButton.icon(
                      onPressed: () {
                        // محاكاة إطلاق كيان السلة المتواجد بالـ Domain لمشروعك
                        final item = CartItemEntity(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: widget.productName,
                          price: widget.productPrice,
                          quantity: _quantity,
                        );
                        context.read<CustomerOrderBloc>().add(
                          UpdateCartItemQuantityEvent(
                            cartItem: item,
                            newQuantity: _quantity,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart_checkout_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'إضافة هذا المنتج إلى السلة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
