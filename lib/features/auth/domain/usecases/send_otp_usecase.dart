import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase({required this.repository});

  // دالة الاستدعاء المباشر للحالة (Callable Class)
  Future<Either<Failure, void>> call(String phoneNumber) async {
    return await repository.sendOtp(phoneNumber);
  }
}
