import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../../data/datasources/order_remote_data_source.dart';
import '../../data/models/payment_model.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/evaluation_entity.dart';
import '../../domain/entities/past_order_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createOrder(OrderEntity order) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> updateOrderStatus(
    String orderId,
    String status,
  ) async => const Right(null);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async =>
      const Right([]);

  @override
  Future<Either<Failure, void>> submitOrderEvaluation(
    EvaluationEntity evaluation,
  ) async => const Right(null);

  @override
  Future<Either<Failure, List<PastOrderEntity>>> getOrderHistory() async =>
      const Right([]);

  @override
  Future<Either<Failure, List<AddressEntity>>> getSavedAddresses() async =>
      const Right([]);

  @override
  Future<Either<Failure, void>> saveNewAddress(AddressEntity address) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> updateCustomerProfile({
    required String name,
    required String phone,
  }) async => const Right(null);

  @override
  Future<Either<Failure, void>> processOrderPayment({
    required PaymentEntity payment,
  }) async => const Right(null);

  @override
  Future<Either<Failure, List<MessageEntity>>> getChatMessages(
    String orderId,
  ) async => const Right([]);

  @override
  Future<Either<Failure, void>> sendChatMessage(
    String orderId,
    MessageEntity message,
  ) async => const Right(null);

  // --- تحديث الدالة: فرز دقيق لـ الفاتورة الإجمالية ١٣٥ ج.م بين المتجر والمندوب والمنصة ---
  @override
  Future<Either<Failure, PaymentEntity>> getPaymentReceiptDetail({
    required String orderId,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return Right(
        PaymentModel(
          transactionId: 'TXN_2026_HATLY',
          orderId: orderId,
          paymentMethod: 'WALLET',
          amountPaid: 135.0, // المبلغ الإجمالي المدفوع من العميل
          paymentStatus: 'SUCCESS',
          merchantShare: 95.0, // صافي حق متجر المقاضي أو الصيدلية عن السلع
          deliveryFee: 30.0, // صافي حق كابتن التوصيل جغرافياً
          platformFee: 10.0, // نسبة تشغيل منصة هاتلي الذكية
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
