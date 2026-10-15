import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hatlyai/features/auth/presentation/customer/bloc/auth_bloc.dart';
import 'package:hatlyai/features/auth/presentation/customer/bloc/auth_event.dart';
import 'package:hatlyai/features/auth/presentation/customer/bloc/auth_state.dart';
import 'package:hatlyai/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:hatlyai/features/auth/domain/entities/security_entity.dart';

class MockSendOtpUseCase extends Mock implements SendOtpUseCase {}

class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AuthBloc authBloc;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    authBloc = AuthBloc(
      sendOtpUseCase: MockSendOtpUseCase(),
      verifyOtpUseCase: MockVerifyOtpUseCase(),
      sharedPreferences: mockSharedPreferences,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  test(
    'الحالة الابتدائية للـ AuthBloc يجب أن تكون من نوع AuthInitialState',
    () {
      expect(authBloc.state, isA<AuthInitialState>());
    },
  );

  blocTest<AuthBloc, AuthState>(
    'يجب أن يطلق [AuthLoadingState] ثم [BiometricSecurityUpdatedState] عند حفظ تفاميل البصمة بنجاح',
    build: () {
      when(
        mockSharedPreferences.setBool(
          anyNamed('key') ?? '',
          anyNamed('value') ?? true,
        ),
      ).thenAnswer((_) => Future.value(true));
      return authBloc;
    },
    act: (bloc) => bloc.add(
      const UpdateBiometricSecuritySettingsEvent(
        securitySettings: SecurityEntity(
          isBiometricEnabled: true,
          isTwoFactorAuthEnabled: false,
          lastSecurityUpdate: '2026',
        ),
      ),
    ),
    expect: () => [
      AuthLoadingState(),
      isA<BiometricSecurityUpdatedState>().having(
        (state) => state.securitySettings.isBiometricEnabled,
        'حالة البصمة الحيوية',
        true,
      ),
    ],
  );
}
