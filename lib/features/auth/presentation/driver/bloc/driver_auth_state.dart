import '../../../domain/entities/user_entity.dart';

abstract class DriverAuthState {
  const DriverAuthState();
}

// الحالة الابتدائية لشاشة المندوب
class DriverAuthInitialState extends DriverAuthState {}

// حالة التحميل أثناء انتظار الرد من السيرفر
class DriverAuthLoadingState extends DriverAuthState {}

// حالة نجاح إرسال رقم الكابتن والتوجيه لصفحة التحقق
class SendDriverOtpSuccessState extends DriverAuthState {}

// حالة نجاح التحقق والولوج لبوابة الوردية بنجاح
class VerifyDriverOtpSuccessState extends DriverAuthState {
  final UserEntity driver;
  const VerifyDriverOtpSuccessState(this.driver);
}

// حالة حدوث خطأ وعرض الرسالة المناسبة للكابتن
class DriverAuthFailureState extends DriverAuthState {
  final String errorMessage;
  const DriverAuthFailureState(this.errorMessage);
}
