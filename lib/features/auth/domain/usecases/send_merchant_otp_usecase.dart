import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SendMerchantOtpUseCase {
  final AuthRepository repository;

  SendMerchantOtpUseCase({required this.repository});

  // دالة الاستدعاء المباشر لإرسال الرمز للتاجر
  Future<Either<Failure, void>> call(String phoneNumber) async {
    return await repository.sendMerchantOtp(phoneNumber);
  }
}
