import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:mapas/models/places_response.dart';

import '../../models/route_destination.dart';
import '../../services/trafict_services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TraficServices trafictServices = TraficServices();
  SearchBloc() : super(const SearchState()) {
    on<SearchEvent>(_init);
    on<OnActivateManualMarkerEvent>(_onActivateManual);
    on<OnNewPlaceFoundEvent>(_onNewPlaceFound);
    on<AddToHistoryEvent>(_addHistory);
  }
  void _init(SearchEvent event, Emitter<SearchState> emit) {}

  void _onActivateManual(OnActivateManualMarkerEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(displayManualMarker: event.isActive));
  }

  void _onNewPlaceFound(OnNewPlaceFoundEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(places: event.places));
  }

  void _addHistory(AddToHistoryEvent event, Emitter<SearchState> emit) {
    final a = state.history.where((element) => element.id == event.place.id).toList();
    if (a.isNotEmpty) return;
    emit(state.copyWith(history: [event.place, ...state.history]));
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final response = await trafictServices.getCoordStartToEnd(start, end);
    final points = decodePolyline(response.routes.first.geometry, accuracyExponent: 6)
        .map(
          (coords) => LatLng(coords[0].toDouble(), coords[1].toDouble()),
        )
        .toList();

    return RouteDestination(
      points: points,
      duration: response.routes.first.distance,
      distance: response.routes.first.duration,
    );
  }

  Future<void> getPlacesByQuery(LatLng proximity, String query) async {
    final response = await trafictServices.getResultByQuery(query, proximity);
    add(OnNewPlaceFoundEvent(places: response));
  }
}
