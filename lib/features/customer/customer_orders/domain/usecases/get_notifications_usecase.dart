import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/notification_entity.dart';
import '../repositories/order_repository.dart';

class GetNotificationsUseCase {
  final OrderRepository repository;

  GetNotificationsUseCase({required this.repository});

  // دالة الاستدعاء المباشر لجلب تاريخ قائمة التنبيهات من مستودع الطلبات بنجاح
  Future<Either<Failure, List<NotificationEntity>>> call() async {
    return await repository.getNotifications();
  }
}
