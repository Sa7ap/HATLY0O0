import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase({required this.repository});

  // دالة الاستدعاء للتحقق من الرمز المكون من رقم الهاتف والـ OTP
  Future<Either<Failure, UserEntity>> call(
    String phoneNumber,
    String otp,
  ) async {
    return await repository.verifyOtp(phoneNumber, otp);
  }
}
