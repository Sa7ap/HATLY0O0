import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// --- الأنماط الاحترافية الجديدة المضافة: لإدارة إخفاقات التشغيل التجارية 2026 ---
class NetworkFailure extends Failure {
  const NetworkFailure(super.message); // خطأ انقطاع اتصال الإنترنت بالجهاز
}

class CacheFailure extends Failure {
  const CacheFailure(super.message); // خطأ فشل قراءة التخزين المحلي الدائم
}

class AuthFailure extends Failure {
  const AuthFailure(super.message); // خطأ فشل التحقق من الرموز الفورية والـ OTP
}
