import '../../auth/domain/entities/user_entity.dart';

abstract class MerchantAuthState {
  const MerchantAuthState();
}

// الحالة الابتدائية لشاشة التاجر
class MerchantAuthInitialState extends MerchantAuthState {}

// حالة التحميل أثناء انتظار الرد من السيرفر
class MerchantAuthLoadingState extends MerchantAuthState {}

// حالة نجاح إرسال رقم التاجر والتوجيه لصفحة التفعيل
class SendMerchantOtpSuccessState extends MerchantAuthState {}

// حالة نجاح التحقق والولوج لبوابة إدارة المتجر بنجاح
class VerifyMerchantOtpSuccessState extends MerchantAuthState {
  final UserEntity merchant;
  const VerifyMerchantOtpSuccessState(this.merchant);
}

// حالة حدوث خطأ وعرض رسالة التنبيه للتاجر
class MerchantAuthFailureState extends MerchantAuthState {
  final String errorMessage;
  const MerchantAuthFailureState(this.errorMessage);
}
