import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas/models/route_destination.dart';

import '../../themes/mapa_style.dart';
import '../location/location_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? _mapController;
  final LocationBloc locationBloc;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? _locationStateSubscription;
  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    on<OnMapInitializeEvent>(_onMapInicialize);
    on<OnStarFollowingUser>(_onStart);
    on<OnStopFollowingUser>(_onStop);
    on<UpdateUserPolylineEvent>(_onUpdate);
    on<OnTogleUserRoute>(_onTogle);
    on<DisplayPoliyneEvent>(_onDisplayPolilyne);

    init();
  }
  void init() {
    _locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }
      if (!state.isFollowingUser) return;
      if (locationState.lastKnowLocation == null) return;
      moveCamera(locationState.lastKnowLocation!);
    });
  }

  void _onMapInicialize(OnMapInitializeEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController?.setMapStyle(json.encode(mapaStyle));
    emit(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng newLocation) {
    final camaraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(camaraUpdate);
  }

  void _onStart(OnStarFollowingUser event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));
    if (locationBloc.state.lastKnowLocation == null) return;
    print("onstart");
    moveCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onStop(OnStopFollowingUser event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: false));
  }

  void _onUpdate(UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userHistoryLocation,
    );
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void _onTogle(OnTogleUserRoute event, Emitter<MapState> emit) {
    emit(state.copyWith(showMyRoute: !state.showMyRoute));
  }

  void _onDisplayPolilyne(DisplayPoliyneEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(polylines: event.polilynes, markers: event.markers, isFollowingUser: false));
  }

  Future<void> drawRoutePolilyne(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.purple,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: destination.points,
    );

    final startMarker = Marker(markerId: const MarkerId('start'), position: destination.points.first);
    final endMarker = Marker(markerId: const MarkerId('end'), position: destination.points.last);

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    final currentPolilyne = Map<String, Polyline>.from(state.polylines);
    currentPolilyne['route'] = myRoute;
    centrarPolyline(destination);
    state.copyWith(isFollowingUser: false);
    add(DisplayPoliyneEvent(
      polilynes: currentPolilyne,
      markers: currentMarkers,
    ));
  }

  Future<void> centrarPolyline(RouteDestination destination) async {
    // _polylines = {};
    // polylineCoordinates = [];
    double latSouthWest = 0;
    double lngSouthWest = 0;
    double latNorthEast = 0;
    double lngNorthEast = 0;

    if (destination.points.first.latitude < destination.points.last.latitude) {
      latSouthWest = destination.points.first.latitude;
      latNorthEast = destination.points.last.latitude;
    } else {
      latSouthWest = destination.points.last.latitude;
      latNorthEast = destination.points.first.latitude;
    }

    if (destination.points.first.longitude < destination.points.last.longitude) {
      lngSouthWest = destination.points.first.longitude;
      lngNorthEast = destination.points.last.longitude;
    } else {
      lngSouthWest = destination.points.last.longitude;
      lngNorthEast = destination.points.first.longitude;
    }

    LatLng southWestLocation = LatLng(latSouthWest, lngSouthWest);
    LatLng northEast = LatLng(latNorthEast, lngNorthEast);

    LatLngBounds bound = LatLngBounds(southwest: southWestLocation, northeast: northEast);

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
    await _mapController?.animateCamera(u2);
    await checkCenter(u2, _mapController!, destination);
  }

  Future<void> checkCenter(CameraUpdate u, GoogleMapController c, RouteDestination solicitud) async {
    c.animateCamera(u);
    _mapController?.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      await checkCenter(u, c, solicitud);
    }
  }

  @override
  Future<void> close() {
    _locationStateSubscription?.cancel();
    return super.close();
  }
}
