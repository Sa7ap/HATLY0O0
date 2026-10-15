import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SendDriverOtpUseCase {
  final AuthRepository repository;

  SendDriverOtpUseCase({required this.repository});

  // دالة الاستدعاء المباشر لإرسال الرمز للمندوب
  Future<Either<Failure, void>> call(String phoneNumber) async {
    return await repository.sendDriverOtp(phoneNumber);
  }
}
