import 'package:equatable/equatable.dart';

abstract class MerchantProductEvent extends Equatable {
  const MerchantProductEvent();

  @override
  List<Object?> get props => [];
}

// 1. حدث طلب إضافة منتج جديد التابع للتاجر
class AddProductRequestedEvent extends MerchantProductEvent {
  final String name;
  final double price;
  final String description;

  const AddProductRequestedEvent({
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  List<Object?> get props => [name, price, description];
}

// 2. حدث طلب جلب وتحديث المبيعات والأرباح التراكمية للمتجر
class GetMerchantStatsRequestedEvent extends MerchantProductEvent {}

// --- الأحداث الجديدة المضافة لإدارة واستقبال وتحديث طلبات المتجر حركياً لعام 2026 ---

// 3. حدث طلب جلب قائمة الطلبات القادمة للمتجر من العملاء
class GetMerchantOrdersEvent extends MerchantProductEvent {}

// 4. حدث طلب تحديث حالة تحضير وطهي الطلب داخل المتجر
class UpdateMerchantOrderStatusEvent extends MerchantProductEvent {
  final String orderId;
  final String newStatus;

  const UpdateMerchantOrderStatusEvent({
    required this.orderId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [orderId, newStatus];
}
