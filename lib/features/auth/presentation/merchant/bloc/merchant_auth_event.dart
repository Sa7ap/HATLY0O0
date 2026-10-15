abstract class MerchantAuthEvent {
  const MerchantAuthEvent();
}

// الحدث الأول: الشريك ضغط على زر إرسال رقم هاتف المتجر
class SendMerchantOtpRequestedEvent extends MerchantAuthEvent {
  final String phoneNumber;
  const SendMerchantOtpRequestedEvent(this.phoneNumber);
}

// الحدث الثاني: الشريك ضغط على زر التحقق من الرمز
class VerifyMerchantOtpRequestedEvent extends MerchantAuthEvent {
  final String phoneNumber;
  final String otp;
  const VerifyMerchantOtpRequestedEvent({
    required this.phoneNumber,
    required this.otp,
  });
}
