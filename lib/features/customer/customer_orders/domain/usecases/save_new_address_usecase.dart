import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/address_entity.dart';
import '../repositories/order_repository.dart';

class SaveNewAddressUseCase {
  final OrderRepository repository;

  SaveNewAddressUseCase({required this.repository});

  // دالة الاستدعاء الموضعية المباشرة لبث وحفظ بيانات الكيان المسجل بالسيرفر
  Future<Either<Failure, void>> call(AddressEntity address) async {
    return await repository.saveNewAddress(address);
  }
}
