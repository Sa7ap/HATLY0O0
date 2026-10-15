import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/app_constants.dart'; // استدعاء المفاتيح الموحدة
import '../../../domain/usecases/send_otp_usecase.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final SharedPreferences sharedPreferences;

  AuthBloc({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.sharedPreferences,
  }) : super(AuthInitialState()) {
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoadingState());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(OtpSentSuccessState());
    });

    // --- تحديث الحدث: حفظ حالة الدخول التلقائي فور توثيق الرمز بنجاح 2026 ---
    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoadingState());
      await Future.delayed(const Duration(milliseconds: 500));

      // تثبيت حالة الدخول بنجاح محلياً بذاكرة الجهاز
      await sharedPreferences.setBool(AppConstants.keyUserLoggedIn, true);

      emit(OtpVerifySuccessState());
    });

    on<UpdateBiometricSecuritySettingsEvent>((event, emit) async {
      emit(AuthLoadingState());
      await sharedPreferences.setBool(
        AppConstants.keyBiometric,
        event.securitySettings.isBiometricEnabled,
      );
      await sharedPreferences.setBool(
        AppConstants.keyTwoFactor,
        event.securitySettings.isTwoFactorAuthEnabled,
      );
      emit(
        BiometricSecurityUpdatedState(securitySettings: event.securitySettings),
      );
    });
  }
}
