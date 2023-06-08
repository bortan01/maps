part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  final double zoom;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRoute = true,
    this.zoom = 15.0,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : polylines = polylines ?? const {},
        markers = markers ?? const {};

  // MapState copyWith({
  //   bool? isMapInitialized,
  //   bool? isFollowingUser,
  //   bool? showMyRoute,
  //   Map<String, Polyline>? polylines,
  // }) =>
  //     MapState(
  //         isMapInitialized: isMapInitialized ?? this.isMapInitialized,
  //         isFollowingUser: isFollowingUser ?? this.isFollowingUser,
  //         polylines: polylines ?? this.polylines,
  //         showMyRoute: showMyRoute ?? this.showMyRoute);
  @override
  List<Object> get props {
    return [
      isMapInitialized,
      isFollowingUser,
      showMyRoute,
      polylines,
      markers,
      zoom,
    ];
  }

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    double? zoom,
  }) {
    return MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
      showMyRoute: showMyRoute ?? this.showMyRoute,
      polylines: polylines ?? this.polylines,
      markers: markers ?? this.markers,
      zoom: zoom ?? this.zoom,
    );
  }
}

class MapInitial extends MapState {}
