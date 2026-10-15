import 'package:equatable/equatable.dart';

import '../../../domain/entities/security_entity.dart'; // استدعاء كيان الأمان الجديد

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;
  const SendOtpEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String otpCode;
  const VerifyOtpEvent({required this.phoneNumber, required this.otpCode});

  @override
  List<Object?> get props => [phoneNumber, otpCode];
}

// --- الحدث الجديد المضاف: تحديث وحفظ تفاصيل تكوين الحماية البيومترية 2026 ---
class UpdateBiometricSecuritySettingsEvent extends AuthEvent {
  final SecurityEntity securitySettings;
  const UpdateBiometricSecuritySettingsEvent({required this.securitySettings});

  @override
  List<Object?> get props => [securitySettings];
}
