import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/payment_entity.dart';
import '../repositories/order_repository.dart';

class ProcessOrderPaymentUseCase {
  final OrderRepository repository;

  ProcessOrderPaymentUseCase({required this.repository});

  // دالة الاستدعاء المعزولة لتمرير حركات الدفع وسداد الفواتير إلى المستودع
  Future<Either<Failure, void>> call({required PaymentEntity payment}) async {
    return await repository.processOrderPayment(payment: payment);
  }
}
