import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../customer/customer_orders/presentation/bloc/customer_order_bloc.dart';
import '../../../customer/customer_orders/presentation/bloc/customer_order_event.dart';
import '../../../customer/customer_orders/presentation/bloc/customer_order_state.dart';

class MerchantOrdersPage extends StatefulWidget {
  const MerchantOrdersPage({super.key});

  @override
  State<MerchantOrdersPage> createState() => _MerchantOrdersPageState();
}

class _MerchantOrdersPageState extends State<MerchantOrdersPage> {
  String _currentStatus =
      'preparing'; // الوضعية التشغيلية الابتدائية للوجبة بالمطبخ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'لوحة المطبخ واستقبال الطلبات 🧑‍🍳',
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
      body: SafeArea(
        child: BlocConsumer<CustomerOrderBloc, CustomerOrderState>(
          listener: (context, state) {
            if (state is MerchantKitchenStatusUpdatedState) {
              setState(() {
                _currentStatus = state.kitchenStatus;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _currentStatus == 'ready'
                        ? 'تم تجهيز الوجبة وبث الإشعار للكابتن! 🚴🔥'
                        : 'الطلب قيد الطهي في المطبخ... 🍳',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // لوحة عرض إحصائيات الأرباح التراكمية الطازجة للتاجر
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.01),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'أرباح المتجر التراكمية اليوم الموثقة',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '1,420 ج.م',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // بطاقة الطلب الحر الوارد الممول من سداد العميل
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'طلب حُر فريد #2026',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                  fontSize: 13,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  'مدفوع رقمياً ✅',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Cairo',
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          const Text(
                            'محتويات الوجبة المطلوبة:',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'وجبة سوبر كومبو حار 🍔🔥 (الكمية: ١)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const Spacer(),

                          // شريط عرض الوضعية التشغيلية للمطبخ حياً
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'حالة الطلب الحالية:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _currentStatus == 'preparing'
                                    ? 'جاري الطهي والتحضير 🍳'
                                    : 'جاهز للتسليم الفوري 🚴✨',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  color: _currentStatus == 'preparing'
                                      ? Colors.amber
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // زر حركي تفاعلي يضغط عليه التاجر لقلب وضعية التحضير
                          ElevatedButton(
                            onPressed:
                                state is CustomerOrderLoadingState ||
                                    _currentStatus == 'ready'
                                ? null
                                : () {
                                    context.read<CustomerOrderBloc>().add(
                                      const MerchantUpdateKitchenStatusEvent(
                                        orderId: '2026',
                                        kitchenStatus: 'ready',
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentStatus == 'ready'
                                  ? Colors.grey
                                  : Colors.orange,
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
                                : Text(
                                    _currentStatus == 'ready'
                                        ? 'تم إشعار الكابتن بالجاهزية'
                                        : 'اضغط للاكتمال وتحويله إلى (جاهز للتسليم)',
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ],
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
