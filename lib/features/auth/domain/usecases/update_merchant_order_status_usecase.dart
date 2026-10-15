import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../repositories/auth_repository.dart';

class UpdateMerchantOrderStatusUseCase {
  final AuthRepository repository;

  UpdateMerchantOrderStatusUseCase({required this.repository});

  // دالة استدعاء السيرفر لتحديث وضعية التحضير والطهي للمنتجات المشتراة
  Future<Either<Failure, void>> call({
    required String orderId,
    required String newStatus,
  }) async {
    return await repository.updateMerchantOrderStatus(
      orderId: orderId,
      newStatus: newStatus,
    );
  }
}
