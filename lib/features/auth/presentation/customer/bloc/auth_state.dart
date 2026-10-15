import 'package:equatable/equatable.dart';

import '../../../domain/entities/security_entity.dart'; // استدعاء كيان الأمان الجديد

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class OtpSentSuccessState extends AuthState {}

class OtpVerifySuccessState extends AuthState {}

// --- الحالة الجديدة المضافة: حالة نجاح تحديث وحفظ الإعدادات البيومترية حركياً 2026 ---
class BiometricSecurityUpdatedState extends AuthState {
  final SecurityEntity securitySettings;
  const BiometricSecurityUpdatedState({required this.securitySettings});

  @override
  List<Object?> get props => [securitySettings];
}

class AuthFailureState extends AuthState {
  final String errorMessage;
  const AuthFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
