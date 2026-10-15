import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/past_order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderHistoryUseCase {
  final OrderRepository repository;

  GetOrderHistoryUseCase({required this.repository});

  // دالة الاستدعاء المباشر لجلب أرشيف الفواتير المكتملة من المستودع بنقاء
  Future<Either<Failure, List<PastOrderEntity>>> call() async {
    return await repository.getOrderHistory();
  }
}
