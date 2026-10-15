import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/payment_entity.dart';
import '../repositories/order_repository.dart';

class GetPaymentReceiptUseCase {
  final OrderRepository repository;

  GetPaymentReceiptUseCase({required this.repository});

  // دالة الاستدعاء المعزولة لجلب وتأكيد كشف حساب إيصال الفاتورة للعميل
  Future<Either<Failure, PaymentEntity>> call({required String orderId}) async {
    return await repository.getPaymentReceiptDetail(orderId: orderId);
  }
}
