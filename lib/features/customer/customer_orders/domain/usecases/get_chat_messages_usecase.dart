import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/message_entity.dart';
import '../repositories/order_repository.dart';

class GetChatMessagesUseCase {
  final OrderRepository repository;

  GetChatMessagesUseCase({required this.repository});

  Future<Either<Failure, List<MessageEntity>>> call(String orderId) async {
    return await repository.getChatMessages(orderId);
  }
}
