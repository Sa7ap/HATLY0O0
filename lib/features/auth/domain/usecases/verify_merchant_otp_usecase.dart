import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyMerchantOtpUseCase {
  final AuthRepository repository;

  VerifyMerchantOtpUseCase({required this.repository});

  // دالة الاستدعاء للتحقق من رمز التاجر وإتمام الدخول
  Future<Either<Failure, UserEntity>> call(
    String phoneNumber,
    String otp,
  ) async {
    return await repository.verifyMerchantOtp(phoneNumber, otp);
  }
}
