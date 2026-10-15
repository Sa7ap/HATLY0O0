import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/wallet_entity.dart';
import '../entities/wallet_transaction_entity.dart'; // استدعاء الكيان الجديد هنا

abstract class WalletRepository {
  Future<Either<Failure, WalletEntity>> getWalletBalance();
  Future<Either<Failure, void>> updateWalletBalance(double amount);

  // --- الدالة الجديدة المضافة: الاستعلام عن قائمة كشف حساب معاملات المحفظة التفصيلي ---
  Future<Either<Failure, List<WalletTransactionEntity>>>
  getWalletTransactions();
}
