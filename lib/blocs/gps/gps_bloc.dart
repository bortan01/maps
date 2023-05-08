import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription<ServiceStatus>? gpsServiceSubscription;

  GpsBloc() : super(const GpsState(isGpsEnable: false, isGpsPermissionGranted: false)) {
    on<GpsAndPermissionEvent>(onGPSAndPermission);
    _init();
  }

  void onGPSAndPermission(GpsAndPermissionEvent event, Emitter<GpsState> emit) {
    emit(
      state.copyWith(
        isGpsEnable: event.isGpsEnable,
        isGpsPermissionGranted: event.isGpsPermissionGranted,
      ),
    );
  }

  Future<void> _init() async {
    final gpsInitialStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    add(GpsAndPermissionEvent(
      isGpsEnable: gpsInitialStatus[0],
      isGpsPermissionGranted: gpsInitialStatus[1],
    ));
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      print('Service Status $event');
      final bool newStatusEnable = event.index == 1;
      add(GpsAndPermissionEvent(
        isGpsEnable: newStatusEnable,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
      ));
    });

    return isEnable;
  }

  Future<void> askGpsAccess() async {
    final status = await handler.Permission.location.request();
    switch (status) {
      case handler.PermissionStatus.granted:
        add(GpsAndPermissionEvent(isGpsEnable: state.isGpsEnable, isGpsPermissionGranted: true));
        break;
      default:
        add(GpsAndPermissionEvent(isGpsEnable: state.isGpsEnable, isGpsPermissionGranted: false));
        handler.openAppSettings();
        break;
    }
  }

  Future<bool> _isPermissionGranted() async {
    return handler.Permission.location.isGranted;
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
