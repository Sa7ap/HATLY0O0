import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase({required this.repository});

  // دالة الاستدعاء المباشر لتمرير كائن الطلب الحر للمستودع
  Future<Either<Failure, void>> call(OrderEntity order) async {
    return await repository.createOrder(order);
  }
}
