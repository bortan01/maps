import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
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
    await _checkGpsStatus();
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((event) {
      print('Service Status $event');
    });

    return isEnable;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
