part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

  const GpsState({required this.isGpsEnable, required this.isGpsPermissionGranted});

  bool get isAllGranted => isGpsEnable && isGpsPermissionGranted;

  GpsState copyWith({
    bool? isGpsEnable,
    bool? isGpsPermissionGranted,
  }) =>
      GpsState(
        isGpsEnable: isGpsEnable ?? this.isGpsEnable,
        isGpsPermissionGranted: isGpsPermissionGranted ?? this.isGpsPermissionGranted,
      );

  @override
  List<Object> get props => [isGpsEnable, isGpsPermissionGranted];

  @override
  String toString() {
    return '{isGpsEnable $isGpsEnable, isGpsPermissionGranted $isGpsPermissionGranted}';
  }
}
