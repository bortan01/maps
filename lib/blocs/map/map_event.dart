part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializeEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializeEvent(this.controller);
}

class OnStopFollowingUser extends MapEvent {}

class OnStarFollowingUser extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userHistoryLocation;

  const UpdateUserPolylineEvent(this.userHistoryLocation);
}

class OnTogleUserRoute extends MapEvent {}

class DisplayPoliyneEvent extends MapEvent {
  final Map<String, Polyline> polilynes;
  final Map<String, Marker> markers;
  const DisplayPoliyneEvent({
    required this.polilynes,
    required this.markers,
  });
}
