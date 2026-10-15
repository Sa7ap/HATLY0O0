import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/domain/usecases/send_driver_otp_usecase.dart';
import '../../auth/domain/usecases/verify_driver_otp_usecase.dart';
import 'driver_auth_event.dart';
import 'driver_auth_state.dart';

class DriverAuthBloc extends Bloc<DriverAuthEvent, DriverAuthState> {
  final SendDriverOtpUseCase sendDriverOtpUseCase;
  final VerifyDriverOtpUseCase verifyDriverOtpUseCase;

  DriverAuthBloc({
    required this.sendDriverOtpUseCase,
    required this.verifyDriverOtpUseCase,
  }) : super(DriverAuthInitialState()) {
    // ربط حدث إرسال رقم هاتف الكابتن بمنطق الـ UseCase
    on<SendDriverOtpRequestedEvent>((event, emit) async {
      emit(DriverAuthLoadingState());
      final result = await sendDriverOtpUseCase.call(event.phoneNumber);

      result.fold(
        (failure) => emit(DriverAuthFailureState(failure.message)),
        (_) => emit(SendDriverOtpSuccessState()),
      );
    });

    // ربط حدث تحقق الرمز الخاص بالمندوب بمنطق الـ UseCase
    on<VerifyDriverOtpRequestedEvent>((event, emit) async {
      emit(DriverAuthLoadingState());
      final result = await verifyDriverOtpUseCase.call(
        event.phoneNumber,
        event.otp,
      );

      result.fold(
        (failure) => emit(DriverAuthFailureState(failure.message)),
        (driverEntity) => emit(VerifyDriverOtpSuccessState(driverEntity)),
      );
    });
  }
}
