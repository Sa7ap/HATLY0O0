import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class AddProductUseCase {
  final AuthRepository repository;

  AddProductUseCase({required this.repository});

  // دالة الاستدعاء المباشر لتمرير البيانات من الواجهة إلى المستودع
  Future<Either<Failure, void>> call({
    required String name,
    required double price,
    required String description,
  }) async {
    return await repository.addProduct(
      name: name,
      price: price,
      description: description,
    );
  }
}
