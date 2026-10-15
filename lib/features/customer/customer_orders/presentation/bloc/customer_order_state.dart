import 'package:equatable/equatable.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/past_order_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/entities/settings_entity.dart';

abstract class CustomerOrderState extends Equatable {
  const CustomerOrderState();

  @override
  List<Object?> get props => [];
}

class CustomerOrderInitialState extends CustomerOrderState {}

class CustomerOrderLoadingState extends CustomerOrderState {}

class CreateOrderSuccessState extends CustomerOrderState {}

class UpdateOrderStatusSuccessState extends CustomerOrderState {
  final String orderId;
  final String newStatus;
  const UpdateOrderStatusSuccessState({
    required this.orderId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [orderId, newStatus];
}

class GetNotificationsSuccessState extends CustomerOrderState {
  final List<NotificationEntity> notifications;
  const GetNotificationsSuccessState({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class GetOrderTrackingSuccessState extends CustomerOrderState {
  final String orderId;
  final String currentStage;
  final double captainLatitude;
  final double captainLongitude;
  const GetOrderTrackingSuccessState({
    required this.orderId,
    required this.currentStage,
    required this.captainLatitude,
    required this.captainLongitude,
  });

  @override
  List<Object?> get props => [
    orderId,
    currentStage,
    captainLatitude,
    captainLongitude,
  ];
}

class SubmitOrderEvaluationSuccessState extends CustomerOrderState {}

class GetOrderHistorySuccessState extends CustomerOrderState {
  final List<PastOrderEntity> orders;
  const GetOrderHistorySuccessState({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class GetChatMessagesSuccessState extends CustomerOrderState {
  final List<MessageEntity> messages;
  const GetChatMessagesSuccessState({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class SendChatMessageSuccessState extends CustomerOrderState {}

class GetSavedAddressesSuccessState extends CustomerOrderState {
  final List<AddressEntity> addresses;
  const GetSavedAddressesSuccessState({required this.addresses});

  @override
  List<Object?> get props => [addresses];
}

class SaveNewAddressSuccessState extends CustomerOrderState {}

class UpdateCustomerProfileSuccessState extends CustomerOrderState {}

class ProcessOrderPaymentSuccessState extends CustomerOrderState {}

class GetPaymentReceiptDetailSuccessState extends CustomerOrderState {
  final PaymentEntity receipt;
  const GetPaymentReceiptDetailSuccessState({required this.receipt});

  @override
  List<Object?> get props => [receipt];
}

class CartItemQuantityUpdatedState extends CustomerOrderState {
  final int updatedQuantity;
  const CartItemQuantityUpdatedState({required this.updatedQuantity});

  @override
  List<Object?> get props => [updatedQuantity];
}

class AppSettingsUpdatedState extends CustomerOrderState {
  final SettingsEntity settings;
  const AppSettingsUpdatedState({required this.settings});

  @override
  List<Object?> get props => [settings];
}

// --- الحالة الجديدة المضافة: حالة نجاح تحديث حالة المطبخ وتجهيز الوجبات حياً 2026 ---
class MerchantKitchenStatusUpdatedState extends CustomerOrderState {
  final String orderId;
  final String kitchenStatus;
  const MerchantKitchenStatusUpdatedState({
    required this.orderId,
    required this.kitchenStatus,
  });

  @override
  List<Object?> get props => [orderId, kitchenStatus];
}

class CustomerOrderFailureState extends CustomerOrderState {
  final String errorMessage;
  const CustomerOrderFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
