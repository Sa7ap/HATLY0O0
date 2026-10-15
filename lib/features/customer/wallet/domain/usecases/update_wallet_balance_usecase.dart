import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../repositories/wallet_repository.dart';

class UpdateWalletBalanceUseCase {
  final WalletRepository repository;

  UpdateWalletBalanceUseCase({required this.repository});

  // دالة الاستدعاء المباشر لتحديث أو شحن رصيد المحفظة بمقدار مالي معين
  Future<Either<Failure, void>> call(double amount) async {
    return await repository.updateWalletBalance(amount);
  }
}
