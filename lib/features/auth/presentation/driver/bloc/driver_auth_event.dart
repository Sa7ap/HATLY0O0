abstract class DriverAuthEvent {
  const DriverAuthEvent();
}

// الحدث الأول: الكابتن ضغط على زر إرسال رقم الهاتف
class SendDriverOtpRequestedEvent extends DriverAuthEvent {
  final String phoneNumber;
  const SendDriverOtpRequestedEvent(this.phoneNumber);
}

// الحدث الثاني: الكابتن ضغط على زر تفعيل الحساب بالرمز
class VerifyDriverOtpRequestedEvent extends DriverAuthEvent {
  final String phoneNumber;
  final String otp;
  const VerifyDriverOtpRequestedEvent({
    required this.phoneNumber,
    required this.otp,
  });
}
