import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/message_entity.dart';
import '../repositories/order_repository.dart';

class SendChatMessageUseCase {
  final OrderRepository repository;

  SendChatMessageUseCase({required this.repository});

  Future<Either<Failure, void>> call(
    String orderId,
    MessageEntity message,
  ) async {
    return await repository.sendChatMessage(orderId, message);
  }
}
