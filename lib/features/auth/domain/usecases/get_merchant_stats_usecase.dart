import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../entities/merchant_stats_entity.dart';
import '../repositories/auth_repository.dart';

class GetMerchantStatsUseCase {
  final AuthRepository repository;

  GetMerchantStatsUseCase({required this.repository});

  // دالة الاستدعاء المباشر لجلب بيانات ومبيعات التاجر التراكمية من المستودع
  Future<Either<Failure, MerchantStatsEntity>> call() async {
    return await repository.getMerchantStats();
  }
}
