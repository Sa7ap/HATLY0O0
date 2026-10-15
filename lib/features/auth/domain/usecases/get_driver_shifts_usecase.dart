import 'package:dartz/dartz.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../entities/driver_shift_entity.dart';
import '../repositories/auth_repository.dart';

class GetDriverShiftsUseCase {
  final AuthRepository repository;

  // تم تصحيح اسم الدالة البانية لتطابق اسم الكلاس تماماً
  GetDriverShiftsUseCase({required this.repository});

  // تم تصحيح القوس الإغلاقي للقائمة > هنا بنجاح
  Future<Either<Failure, List<DriverShiftEntity>>> call() async {
    return await repository.getDriverShifts();
  }
}
