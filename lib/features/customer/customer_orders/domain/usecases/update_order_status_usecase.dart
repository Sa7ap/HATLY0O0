import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../repositories/order_repository.dart';

class UpdateOrderStatusUseCase {
  final OrderRepository repository;

  UpdateOrderStatusUseCase({required this.repository});

  // دالة الاستدعاء المباشر لتمرير معرف الطلب والحالة الجديدة للمستودع
  // دالة استدعاء السيرفر لتحديث وضعية الطلب عبر تمرير القيم موضعياً مباشرة
  Future<Either<Failure, void>> call({
    required String orderId,
    required String newStatus,
  }) async {
    // تصحيح: تمرير القيم مباشرة بدون أسماء حقول لتطابق دالة المستودع الأصلي
    return await repository.updateOrderStatus(orderId, newStatus);
  }
}
