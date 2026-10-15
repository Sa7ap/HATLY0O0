// الجزء 1 من 2: ملف lib/features/customer/customer_orders/presentation/order_tracker_view.dart
// تحديث الكلاس ليدعم استقبال orderId لمنع التعارض مع صفحة الدفع وإصلاح الخطأ تماماً

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlyai/core/theme/app_theme.dart';

import 'bloc/customer_order_bloc.dart';
import 'bloc/customer_order_state.dart';

class OrderTrackerView extends StatelessWidget {
  // إضافة متغير orderId لاستقبال المعرف الممرر من صفحة الدفع بنجاح
  final String orderId;

  const OrderTrackerView({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع الطلب الحالي'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType ||
            (previous is GetOrderTrackingSuccessState &&
                current is GetOrderTrackingSuccessState &&
                previous.currentStage != current.currentStage),
        builder: (context, state) {
          if (state is CustomerOrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryOrange),
            );
          }

          String currentStage = '1';
          if (state is GetOrderTrackingSuccessState) {
            currentStage = state.currentStage;
          }

          // تمرير المعرف والمرحلة الحالية للواجهة الداخلية
          return _OrderTrackerContent(
            orderId: orderId,
            currentStage: currentStage,
          );
        },
      ),
    );
  }
}

// ويدجت عرض المحتوى الداخلي المعدل لاستقبال معطيات معرف الطلب
class _OrderTrackerContent extends StatelessWidget {
  final String orderId;
  final String currentStage;

  const _OrderTrackerContent({
    required this.orderId,
    required this.currentStage,
  });

  @override
  Widget build(BuildContext context) {
    final int stageIndex = int.tryParse(currentStage) ?? 1;

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.lightOrange,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.primaryOrange.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عرض معرف الطلب الحقيقي الممرر من صفحة الدفع مباشرة داخل الواجهة
                  Text(
                    'طلب رقم #$orderId',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.darkOrange,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'وقت التوصيل المقدر: 30 - 45 دقيقة',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              const Icon(
                Icons.local_shipping_rounded,
                color: AppTheme.primaryOrange,
                size: 32,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'مراحل التجهيز والتوصيل',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 24),
        // الجزء 2 من 2: ملف lib/features/customer/customer_orders/presentation/order_tracker_view.dart
        // استكمال خطوات الجدول الزمني الخمس المتطابقة وإغلاق الملف تماماً لمنع أي خطأ بصري أو برمي

        // المرحلة الأولى: تم إرسال الطلب (تنشط إذا كان المؤشر 1 أو أكبر)
        _TimelineStep(
          title: 'تم إرسال الطلب بنجاح',
          subtitle: 'في انتظار تأكيد المتجر وتعيين الكابتن له',
          isFirst: true,
          isActive: stageIndex == 1,
          isCompleted: stageIndex > 1,
        ),
        // المرحلة الثانية: قبول الطلب من المندوب
        _TimelineStep(
          title: 'تم قبول الطلب من المندوب',
          subtitle: 'الكابتن في طريقه الآن إلى المتجر لاستلام طلبك',
          isActive: stageIndex == 2,
          isCompleted: stageIndex > 2,
        ),
        // المرحلة الثالثة: تجهيز الطلب داخل المطبخ أو المتجر
        _TimelineStep(
          title: 'يقوم المندوب بتجهيز الطلب',
          subtitle: 'يتم الآن فحص العناصر وتغليفها داخل المتجر بدقة',
          isActive: stageIndex == 3,
          isCompleted: stageIndex > 3,
        ),
        // المرحلة الرابعة: المندوب في طريق التوصيل
        _TimelineStep(
          title: 'المندوب في طريقه إليك',
          subtitle: 'طلبك خرج مع الكابتن وهو متوجه إلى عنوانك الآن',
          isActive: stageIndex == 4,
          isCompleted: stageIndex > 4,
        ),
        // المرحلة الخامسة والأخيرة: تأكيد التسليم النهائي والوصول
        _TimelineStep(
          title: 'تأكيد التسليم والتقييم',
          subtitle: 'يرجى تأكيد الاستلام عند وصول الكابتن وتقييم الخدمة',
          isLast: true,
          isActive: stageIndex == 5,
          isCompleted: stageIndex > 5,
        ),
      ],
    );
  }
}

// ويدجت الخطوة العمودية للجدول الزمني الملون بنظام الهوية البرتقالية الموحدة
class _TimelineStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isFirst;
  final bool isLast;
  final bool isActive;
  final bool isCompleted;

  const _TimelineStep({
    required this.title,
    required this.subtitle,
    this.isFirst = false,
    this.isLast = false,
    required this.isActive,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // الدائرة البصرية وتلوينها بناءً على الحالة الحية القادمة من الـ Bloc الخاص بك
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppTheme.primaryOrange
                    : (isActive
                          ? const Color(0xFFFFB300)
                          : Colors.grey.shade300),
                border: Border.all(
                  color: isCompleted ? AppTheme.darkOrange : Colors.white,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            // الخط الواصل التتابعي بين الدوائر العمودية
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isCompleted
                    ? AppTheme.primaryOrange
                    : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        // محتوى النصوص والعناوين الفرعية لكل مرحلة للتوصيل
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isActive || isCompleted
                      ? AppTheme.textDark
                      : AppTheme.textLight,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textLight,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
