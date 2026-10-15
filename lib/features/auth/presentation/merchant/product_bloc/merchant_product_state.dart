import 'package:equatable/equatable.dart';

import '../../../domain/entities/merchant_stats_entity.dart';
import '../../../domain/entities/merchant_order_entity.dart'; // استدعاء كيان طلبات التاجر الجديد

abstract class MerchantProductState extends Equatable {
  const MerchantProductState();

  @override
  List<Object?> get props => [];
}

// 1. الحالات الابتدائية والتحميل العامة للتاجر
class MerchantProductInitialState extends MerchantProductState {}

class MerchantProductLoadingState extends MerchantProductState {}

// 2. حالة نجاح إضافة منتج جديد وحالة نجاح جلب الإحصائيات التراكمية
class AddProductSuccessState extends MerchantProductState {}

class GetMerchantStatsSuccessState extends MerchantProductState {
  final MerchantStatsEntity stats;
  const GetMerchantStatsSuccessState({required this.stats});

  @override
  List<Object?> get props => [stats];
}

// --- الحالات الجديدة المضافة: لإدارة واستقبال طلبات المتجر حركياً بنقاء تّام ---

// 3. حالة نجاح جلب وتحديث قائمة الطلبات القادمة للمتجر
class GetMerchantOrdersSuccessState extends MerchantProductState {
  final List<MerchantOrderEntity> orders;

  const GetMerchantOrdersSuccessState({required this.orders});

  @override
  List<Object?> get props => [orders];
}

// 4. حالة نجاح تحديث حالة الطلب والطهي داخل المطبخ
class UpdateMerchantOrderStatusSuccessState extends MerchantProductState {
  final String orderId;
  final String newStatus;

  const UpdateMerchantOrderStatusSuccessState({
    required this.orderId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [orderId, newStatus];
}

// 5. حالة حدوث خطأ تشغيلي أو فشل في الاتصال بالسيرفر
class MerchantProductFailureState extends MerchantProductState {
  final String errorMessage;
  const MerchantProductFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
