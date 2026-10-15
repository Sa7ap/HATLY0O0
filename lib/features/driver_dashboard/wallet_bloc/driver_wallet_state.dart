import 'package:equatable/equatable.dart';

import '../../auth/domain/entities/driver_shift_entity.dart';

abstract class DriverWalletState extends Equatable {
  const DriverWalletState();

  @override
  List<Object?> get props => [];
}

class DriverWalletInitialState extends DriverWalletState {}

class DriverWalletLoadingState extends DriverWalletState {}

class DriverWalletSuccessState extends DriverWalletState {}

// --- الحالة الجديدة المضافة: حالة نجاح جلب الأرباح التراكمية وتحديث محفظة الكابتن 2026 ---
class DriverWalletBalancesLoadedState extends DriverWalletState {
  final double totalEarnings; // قيمة الأرباح المحدثة الـ 450 ج.م
  final List<DriverShiftEntity> activeShifts; // الوردية الجغرافية بمحيط 30 كم

  const DriverWalletBalancesLoadedState({
    required this.totalEarnings,
    required this.activeShifts,
  });

  @override
  List<Object?> get props => [totalEarnings, activeShifts];
}

class DriverWalletFailureState extends DriverWalletState {
  final String errorMessage;
  const DriverWalletFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
