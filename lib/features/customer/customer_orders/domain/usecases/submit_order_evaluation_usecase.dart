import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/evaluation_entity.dart';
import '../repositories/order_repository.dart';

class SubmitOrderEvaluationUseCase {
  final OrderRepository repository;

  SubmitOrderEvaluationUseCase({required this.repository});

  // دالة الاستدعاء المباشر لإرسال وحفظ النجمات والتعليقات داخل المستودع بنقاء
  Future<Either<Failure, void>> call(EvaluationEntity evaluation) async {
    return await repository.submitOrderEvaluation(evaluation);
  }
}
