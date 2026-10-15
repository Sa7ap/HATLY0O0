import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/address_entity.dart';
import '../repositories/order_repository.dart';

class GetSavedAddressesUseCase {
  final OrderRepository repository;

  GetSavedAddressesUseCase({required this.repository});

  // دالة الاستدعاء المعزولة لجلب العناوين الجغرافية المحفوظة للعميل
  Future<Either<Failure, List<AddressEntity>>> call() async {
    return await repository.getSavedAddresses();
  }
}
