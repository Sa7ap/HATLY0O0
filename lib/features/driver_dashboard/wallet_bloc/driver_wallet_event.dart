import 'package:equatable/equatable.dart';

abstract class DriverWalletEvent extends Equatable {
  const DriverWalletEvent();

  @override
  List<Object?> get props => [];
}

class GetDriverWalletRequestedEvent extends DriverWalletEvent {}

class GetDriverShiftsRequestedEvent extends DriverWalletEvent {}

// --- الحدث الجديد المضاف: جلب وتحديث الأرباح المالية والورديات الحية للكابتن 2026 ---
class RefreshDriverWalletBalancesEvent extends DriverWalletEvent {
  final String driverId;
  const RefreshDriverWalletBalancesEvent({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}
