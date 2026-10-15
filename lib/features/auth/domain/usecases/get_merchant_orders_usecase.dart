import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../entities/merchant_order_entity.dart';
import '../repositories/auth_repository.dart';

class GetMerchantOrdersUseCase {
  final AuthRepository repository;

  GetMerchantOrdersUseCase({required this.repository});

  // دالة الاستدعاء المباشر لجلب قائمة طلبات المتجر القادمة من المستودع
  Future<Either<Failure, List<MerchantOrderEntity>>> call() async {
    return await repository.getMerchantOrders();
  }
}
