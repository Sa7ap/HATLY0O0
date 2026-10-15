// الجزء 1 من 1: ملف customer_evaluation_page.dart المصحح والنهائي بالكامل
// تم تحويل المتغير إلى double وإسناد دالة التغيير التفاعلية الجديدة لحل الخطوط الحمراء تماماً

import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/star_rating_bar.dart';

class CustomerEvaluationPage extends StatefulWidget {
  const CustomerEvaluationPage({super.key});

  @override
  State<CustomerEvaluationPage> createState() => _CustomerEvaluationPageState();
}

class _CustomerEvaluationPageState extends State<CustomerEvaluationPage> {
  // تم تعديل نوع المتغير إلى double ليتوافق بنيوياً مع شريط النجوم ويمنع خطأ التعارض
  double _selectedStars = 4.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تقييم الطلب')),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'كيف كانت تجربة التوصيل لطلبك؟',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // استدعاء شريط النجوم المطور والتفاعلي بالهوية البرتقالية الموحدة
          Center(
            child: StarRatingBar(
              rating: _selectedStars,
              starSize: 32.0, // تكبير حجم النجوم لسهولة الضغط عليها من العميل
              onRatingChanged: (stars) {
                setState(() {
                  _selectedStars = stars; // تحديث النجوم ديناميكياً عند الضغط
                });
              },
            ),
          ),

          const SizedBox(height: 32),
          TextFormField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: '...اكتب تعليقك أو ملاحظاتك هنا للكابتن والمتجر',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // تنفيذ عمليات الحفظ التراكمية المكتوبة مسبقاً في مشروعك وثم الرجوع
              Navigator.pop(context);
            },
            child: const Text('إرسال التقييم النهائي'),
          ),
        ],
      ),
    );
  }
}
