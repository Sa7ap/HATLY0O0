import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../auth/domain/usecases/get_driver_wallet_usecase.dart';
import '../../../../auth/domain/usecases/get_driver_shifts_usecase.dart';
import '../../../../auth/domain/entities/driver_shift_entity.dart';
import 'driver_wallet_event.dart';
import 'driver_wallet_state.dart';

class DriverWalletBloc extends Bloc<DriverWalletEvent, DriverWalletState> {
  final GetDriverWalletUseCase getDriverWalletUseCase;
  final GetDriverShiftsUseCase getDriverShiftsUseCase;
  final SharedPreferences
  sharedPreferences; // Injected shared preferences instance

  DriverWalletBloc({
    required this.getDriverWalletUseCase,
    required this.getDriverShiftsUseCase,
    required this.sharedPreferences,
  }) : super(DriverWalletInitialState()) {
    on<GetDriverWalletRequestedEvent>((event, emit) async {
      emit(DriverWalletLoadingState());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(DriverWalletSuccessState());
    });

    // --- Updated Handling: Reads Dynamic Balanced Credited by the Customer Payment ---
    on<RefreshDriverWalletBalancesEvent>((event, emit) async {
      emit(DriverWalletLoadingState());
      await Future.delayed(const Duration(milliseconds: 300));

      // Reading the updated real-time credited amount from preferences
      double liveEarnings =
          sharedPreferences.getDouble('driver_wallet_balance') ?? 450.0;

      final mockShifts = [
        const DriverShiftEntity(
          id: 'shift_2026',
          orderSummary: 'طلب توصيل حُر',
          deliveryEarnings: 450.0,
          distance: '30 كم',
          date: '2026-10-12',
        ),
      ];

      emit(
        DriverWalletBalancesLoadedState(
          totalEarnings: liveEarnings,
          activeShifts: mockShifts,
        ),
      );
    });
  }
}
