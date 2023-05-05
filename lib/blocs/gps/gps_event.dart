part of 'gps_bloc.dart';

@immutable
abstract class GpsEvent {}

class GpsAndPermissionEvent extends GpsEvent {
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

   GpsAndPermissionEvent({
    required this.isGpsEnable,
    required this.isGpsPermissionGranted,
  });
}
