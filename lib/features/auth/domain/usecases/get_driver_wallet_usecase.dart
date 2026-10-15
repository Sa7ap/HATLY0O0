import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../entities/driver_wallet_entity.dart';
import '../repositories/auth_repository.dart';

class GetDriverWalletUseCase {
  final AuthRepository repository;

  GetDriverWalletUseCase({required this.repository});

  // دالة الاستدعاء المباشر لجلب بيانات وأرباح محفظة المندوب التراكمية من المستودع
  Future<Either<Failure, DriverWalletEntity>> call() async {
    return await repository.getDriverWallet();
  }
}
