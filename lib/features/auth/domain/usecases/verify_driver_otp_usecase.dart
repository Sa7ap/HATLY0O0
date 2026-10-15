import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyDriverOtpUseCase {
  final AuthRepository repository;

  VerifyDriverOtpUseCase({required this.repository});

  // دالة الاستدعاء للتحقق من رمز المندوب
  Future<Either<Failure, UserEntity>> call(
    String phoneNumber,
    String otp,
  ) async {
    return await repository.verifyDriverOtp(phoneNumber, otp);
  }
}
