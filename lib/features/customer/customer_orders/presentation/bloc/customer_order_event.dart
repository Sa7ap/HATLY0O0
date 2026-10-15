import 'package:equatable/equatable.dart';

import '../../domain/entities/evaluation_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/settings_entity.dart';

abstract class CustomerOrderEvent extends Equatable {
  const CustomerOrderEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrderRequestedEvent extends CustomerOrderEvent {
  final Map<String, dynamic> orderData;
  const CreateOrderRequestedEvent(this.orderData);

  @override
  List<Object?> get props => [orderData];
}

class UpdateOrderStatusRequestedEvent extends CustomerOrderEvent {
  final String orderId;
  final String newStatus;
  const UpdateOrderStatusRequestedEvent({
    required this.orderId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [orderId, newStatus];
}

class GetNotificationsEvent extends CustomerOrderEvent {}

class SubmitOrderEvaluationEvent extends CustomerOrderEvent {
  final EvaluationEntity evaluation;
  const SubmitOrderEvaluationEvent({required this.evaluation});

  @override
  List<Object?> get props => [evaluation];
}

class StartOrderTrackingEvent extends CustomerOrderEvent {
  final String orderId;
  const StartOrderTrackingEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class GetChatMessagesEvent extends CustomerOrderEvent {
  final String orderId;
  const GetChatMessagesEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class SendChatMessageEvent extends CustomerOrderEvent {
  final String orderId;
  final MessageEntity message;
  const SendChatMessageEvent({required this.orderId, required this.message});

  @override
  List<Object?> get props => [orderId, message];
}

class GetOrderHistoryEvent extends CustomerOrderEvent {}

class GetSavedAddressesEvent extends CustomerOrderEvent {}

class SaveNewAddressEvent extends CustomerOrderEvent {
  final AddressEntity address;
  const SaveNewAddressEvent({required this.address});

  @override
  List<Object?> get props => [address];
}

class UpdateCustomerProfileEvent extends CustomerOrderEvent {
  final String name;
  final String phone;
  const UpdateCustomerProfileEvent({required this.name, required this.phone});

  @override
  List<Object?> get props => [name, phone];
}

class ProcessOrderPaymentEvent extends CustomerOrderEvent {
  final PaymentEntity payment;
  const ProcessOrderPaymentEvent({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class GetPaymentReceiptDetailEvent extends CustomerOrderEvent {
  final String orderId;
  const GetPaymentReceiptDetailEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class UpdateCartItemQuantityEvent extends CustomerOrderEvent {
  final CartItemEntity cartItem;
  final int newQuantity;
  const UpdateCartItemQuantityEvent({
    required this.cartItem,
    required this.newQuantity,
  });

  @override
  List<Object?> get props => [cartItem, newQuantity];
}

class UpdateAppSettingsEvent extends CustomerOrderEvent {
  final SettingsEntity settings;
  const UpdateAppSettingsEvent({required this.settings});

  @override
  List<Object?> get props => [settings];
}

// --- الحدث الجديد المضاف: تمكين التاجر من تحديث وضعية طهي وتجهيز السلعة حركياً 2026 ---
class MerchantUpdateKitchenStatusEvent extends CustomerOrderEvent {
  final String orderId;
  final String kitchenStatus; // مثال: 'preparing' أو 'ready'

  const MerchantUpdateKitchenStatusEvent({
    required this.orderId,
    required this.kitchenStatus,
  });

  @override
  List<Object?> get props => [orderId, kitchenStatus];
}
