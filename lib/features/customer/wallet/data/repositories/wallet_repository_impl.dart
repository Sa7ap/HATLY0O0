import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../../data/datasources/wallet_remote_data_source.dart';
import '../../data/models/wallet_model.dart';
import '../../data/models/wallet_transaction_model.dart'; // استدعاء موديل المعاملات الجديد
import '../../domain/entities/wallet_entity.dart';
import '../../domain/entities/wallet_transaction_entity.dart';
import '../../domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, WalletEntity>> getWalletBalance() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      // تصحيح: إضافة حقل العملة الإجباري المعتمد بمشروعك لحل المشكلة فوراً
      final mockWallet = WalletModel(balance: 250.0, currency: 'ج.م');
      return Right(mockWallet);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateWalletBalance(double amount) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // --- الدالة الجديدة المضافة: تنفيذ محاكاة كشف حساب المعاملات للعميل بنجاح ---
  @override
  Future<Either<Failure, List<WalletTransactionEntity>>>
  getWalletTransactions() async {
    try {
      // محاكاة تأخير الشبكة لمدة ثانية لعرض مؤشر التحميل بسلاسة
      await Future.delayed(const Duration(seconds: 1));

      // إنشاء قائمة معاملات وهمية تعكس حركات الشحن والخصم الفعليّة للعميل
      final List<WalletTransactionModel> mockTransactions = [
        const WalletTransactionModel(
          id: 'tx_01',
          title: 'شحن رصيد المحفظة 💳',
          amount: 250.0,
          date: '2026-10-10 14:30',
          isCredit: true, // شحن (+)
        ),
        const WalletTransactionModel(
          id: 'tx_02',
          title: 'طلب توصيل حر (وجبة برجر) 🍔',
          amount: 35.0,
          date: '2026-10-10 16:15',
          isCredit: false, // خصم (-)
        ),
        const WalletTransactionModel(
          id: 'tx_03',
          title: 'طلب شراء من الصيدلية 💊',
          amount: 52.0,
          date: '2026-10-10 18:45',
          isCredit: false, // خصم (-)
        ),
      ];

      return Right(mockTransactions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
