import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/empty_state_widget.dart'; // استدعاء الودجت الموحدة

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'أرشيف سجل الطلبات 📄',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'Cairo', fontSize: 14),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // دمج وعرض واجهة الأرشيف الفارغ الموحدة بنقاء تام لعام 2026
      body: const EmptyStateWidget(
        icon: Icons.receipt_long_rounded,
        title: 'أرشيف الفواتير فارغ تماماً',
        subtitle: 'لم تقم بإصدار أي طلبات حرة حتى الآن، كل معاملاتك المالية ستظهر هنا حياً فور اكتمالها.',
      ),
    );
  }
}
