import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../entities/wallet_entity.dart';
import '../repositories/wallet_repository.dart';

class GetWalletBalanceUseCase {
  final WalletRepository repository;

  GetWalletBalanceUseCase({required this.repository});

  // دالة الاستدعاء المباشر لجلب بيانات ورصيد المحفظة من المستودع
  Future<Either<Failure, WalletEntity>> call() async {
    return await repository.getWalletBalance();
  }
}
