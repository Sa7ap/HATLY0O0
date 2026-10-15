import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../entities/notification_entity.dart';
import '../entities/evaluation_entity.dart';
import '../entities/past_order_entity.dart';
import '../entities/address_entity.dart';
import '../entities/payment_entity.dart';
import '../entities/message_entity.dart'; // الاستيراد الجديد لكيان الرسائل

abstract class OrderRepository {
  Future<Either<Failure, void>> createOrder(OrderEntity order);
  Future<Either<Failure, void>> updateOrderStatus(
    String orderId,
    String status,
  );
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
  Future<Either<Failure, void>> submitOrderEvaluation(
    EvaluationEntity evaluation,
  );
  Future<Either<Failure, List<PastOrderEntity>>> getOrderHistory();
  Future<Either<Failure, List<AddressEntity>>> getSavedAddresses();
  Future<Either<Failure, void>> saveNewAddress(AddressEntity address);
  Future<Either<Failure, void>> updateCustomerProfile({
    required String name,
    required String phone,
  });
  Future<Either<Failure, void>> processOrderPayment({
    required PaymentEntity payment,
  });
  Future<Either<Failure, PaymentEntity>> getPaymentReceiptDetail({
    required String orderId,
  });

  // --- الدالات الجديدة المضافة: لتنشيط وإدارة غرف الشات والمحادثة الفورية 2026 ---
  Future<Either<Failure, List<MessageEntity>>> getChatMessages(String orderId);
  Future<Either<Failure, void>> sendChatMessage(
    String orderId,
    MessageEntity message,
  );
}
