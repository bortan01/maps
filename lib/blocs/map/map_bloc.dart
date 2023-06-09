import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas/models/route_destination.dart';

import '../../helpers/widgets_to_image.dart';
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
    on<UpdateZoomEvent>(_onUpdateZoom);

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

  _onDisplayPolilyne(DisplayPoliyneEvent event, Emitter<MapState> emit) async {
    double currentZoom = await _mapController?.getZoomLevel() ?? 15;
    emit(state.copyWith(polylines: event.polilynes, markers: event.markers, isFollowingUser: false, zoom: currentZoom));
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

    double kms = destination.distance / 1000;
    kms = (kms * 100).roundToDouble();
    kms / 100;

    int tripDuration = (destination.duration / 60).roundToDouble().toInt();

    // final starMarketIcon = await getAssetImageMarket();
    // final endMarkerIcon = await getNetworkImageMarker();

    final starMarketIcon = await getStartCusmtomMarker(
      destination: 'Mi ubicacion',
      minutes: tripDuration,
    );
    final endMarkerIcon = await getEndCusmtomMarker(
      destination: destination.endPlaceInfo.text ?? '',
      kilometros: kms.toInt(),
    );

    final startMarker = Marker(
        markerId: const MarkerId('start'),
        position: destination.points.first,
        icon: starMarketIcon,
        anchor: const Offset(0.060, 0.87)
        // infoWindow: InfoWindow(
        //   title: 'Inicio',
        //   snippet: 'Distancia: $kms km, duracion $tripDuration h',
        // ),
        );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMarkerIcon,
      // anchor: Offset(dx, dy),
      // infoWindow: InfoWindow(
      //   title: destination.endPlaceInfo.text,
      //   snippet: destination.endPlaceInfo.placeName,
      // ),
    );

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    final currentPolilyne = Map<String, Polyline>.from(state.polylines);
    currentPolilyne['route'] = myRoute;
    await centrarPolyline(destination);
    state.copyWith(isFollowingUser: false);

    add(DisplayPoliyneEvent(
      polilynes: currentPolilyne,
      markers: currentMarkers,
    ));
    await Future.delayed(const Duration(milliseconds: 300));
    // _mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  Future<void> centrarPolyline(RouteDestination destination) async {
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

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 90);
    await _mapController?.animateCamera(u2);
    // await checkCenter(u2, _mapController!);
  }

  Future<void> checkCenter(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    _mapController?.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      await checkCenter(u, c);
    }
  }

  @override
  Future<void> close() {
    _locationStateSubscription?.cancel();
    return super.close();
  }

  void _onUpdateZoom(UpdateZoomEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(zoom: event.zoom));
  }
}
