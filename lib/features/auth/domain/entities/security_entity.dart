import 'package:equatable/equatable.dart';

class SecurityEntity extends Equatable {
  final bool isBiometricEnabled; // حالة تفعيل بصمة الإصبع أو الوجه بالتطبيق
  final bool
  isTwoFactorAuthEnabled; // حالة تفعيل التحقق بخطوتين عبر الرموز الفورية
  final String
  lastSecurityUpdate; // تاريخ آخر تحديث وتأمين لكلمات المرور والحساب

  const SecurityEntity({
    required this.isBiometricEnabled,
    required this.isTwoFactorAuthEnabled,
    required this.lastSecurityUpdate,
  });

  @override
  List<Object?> get props => [
    isBiometricEnabled,
    isTwoFactorAuthEnabled,
    lastSecurityUpdate,
  ];
}
