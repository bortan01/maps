import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positions;

  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {});
    on<OnNewUserLocationEvent>(onNewUser);
    on<OnStartFollowingUser>(onStartFollowingUser);
    on<OnStopFollowingUser>(onStopFollowingUser);
  }

  @override
  Future<void> close() {
    positions?.cancel();
    return super.close();
  }

  Future<void> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    print(position);
  }

  void starFollowingUser() {
    add(OnStartFollowingUser());
    positions = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
    });
  }

  void stopFlollowingUser() {
    positions?.cancel();
    add(OnStopFollowingUser());
  }

  void onNewUser(OnNewUserLocationEvent event, Emitter<LocationState> emit) {
    emit(
      state.copyWith(
        lastKnowLocation: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation],
      ),
    );
  }

  void onStartFollowingUser(OnStartFollowingUser event, Emitter<LocationState> emit) {
    emit(state.copyWith(followingUser: true));
  }

  void onStopFollowingUser(OnStopFollowingUser event, Emitter<LocationState> emit) {
    emit(state.copyWith(followingUser: false));
  }
}
