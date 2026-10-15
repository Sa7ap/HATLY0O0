import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/order_repository.dart';

class UpdateCustomerProfileUseCase {
  final OrderRepository repository;

  UpdateCustomerProfileUseCase({required this.repository});

  // دالة استدعاء معزولة ومحمية لتمرير تحديثات الحساب الشخصي للمستودع
  Future<Either<Failure, void>> call({
    required String name,
    required String phone,
  }) async {
    return await repository.updateCustomerProfile(name: name, phone: phone);
  }
}
