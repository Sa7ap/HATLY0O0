import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/domain/usecases/send_merchant_otp_usecase.dart';
import '../../auth/domain/usecases/verify_merchant_otp_usecase.dart';
import 'merchant_auth_event.dart';
import 'merchant_auth_state.dart';

class MerchantAuthBloc extends Bloc<MerchantAuthEvent, MerchantAuthState> {
  final SendMerchantOtpUseCase sendMerchantOtpUseCase;
  final VerifyMerchantOtpUseCase verifyMerchantOtpUseCase;

  MerchantAuthBloc({
    required this.sendMerchantOtpUseCase,
    required this.verifyMerchantOtpUseCase,
  }) : super(MerchantAuthInitialState()) {
    // ربط حدث إرسال رقم هاتف المتجر بمنطق الـ UseCase
    on<SendMerchantOtpRequestedEvent>((event, emit) async {
      emit(MerchantAuthLoadingState());
      final result = await sendMerchantOtpUseCase.call(event.phoneNumber);

      result.fold(
        (failure) => emit(MerchantAuthFailureState(failure.message)),
        (_) => emit(SendMerchantOtpSuccessState()),
      );
    });

    // ربط حدث تحقق الرمز الخاص بالتاجر بمنطق الـ UseCase
    on<VerifyMerchantOtpRequestedEvent>((event, emit) async {
      emit(MerchantAuthLoadingState());
      final result = await verifyMerchantOtpUseCase.call(
        event.phoneNumber,
        event.otp,
      );

      result.fold(
        (failure) => emit(MerchantAuthFailureState(failure.message)),
        (merchantEntity) => emit(VerifyMerchantOtpSuccessState(merchantEntity)),
      );
    });
  }
}
