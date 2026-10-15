import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../entities/wallet_transaction_entity.dart';
import '../repositories/wallet_repository.dart';

class GetWalletTransactionsUseCase {
  final WalletRepository repository;

  GetWalletTransactionsUseCase({required this.repository});

  // دالة الاستدعاء المباشر لجلب قائمة كشف حساب المعاملات الماليّة من المستودع
  Future<Either<Failure, List<WalletTransactionEntity>>> call() async {
    return await repository.getWalletTransactions();
  }
}
