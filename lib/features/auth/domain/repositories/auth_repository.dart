import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../entities/driver_wallet_entity.dart';
import '../entities/merchant_stats_entity.dart';
import '../entities/driver_shift_entity.dart';
import '../entities/merchant_order_entity.dart'; // استدعاء الكيان الجديد هنا

abstract class AuthRepository {
  Future<Either<Failure, void>> sendOtp(String phone);
  Future<Either<Failure, UserEntity>> verifyOtp(String phone, String code);
  
  Future<Either<Failure, void>> sendDriverOtp(String phone);
  Future<Either<Failure, UserEntity>> verifyDriverOtp(String phone, String code);
  
  Future<Either<Failure, void>> sendMerchantOtp(String phone);
  Future<Either<Failure, UserEntity>> verifyMerchantOtp(String phone, String code);
  
  Future<Either<Failure, void>> addProduct({
    required String name,
    required double price,
    required String description,
  });

  Future<Either<Failure, DriverWalletEntity>> getDriverWallet();
  Future<Either<Failure, MerchantStatsEntity>> getMerchantStats();
  Future<Either<Failure, List<DriverShiftEntity>>> getDriverShifts();

  // --- الدالتان الجديدتان المضافتان لإدارة واستقبال وتحديث طلبات التاجر حركياً ---
  Future<Either<Failure, List<MerchantOrderEntity>>> getMerchantOrders();
  Future<Either<Failure, void>> updateMerchantOrderStatus({
    required String orderId,
    required String newStatus,
  });
}
