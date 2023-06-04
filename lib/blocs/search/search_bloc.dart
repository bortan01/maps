import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import '../../models/route_destination.dart';
import '../../services/trafict_services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafictServices trafictServices = TrafictServices();
  SearchBloc() : super(const SearchState()) {
    on<SearchEvent>(_init);
    on<OnActivateManualMarkerEvent>(_onActivateManual);
  }
  void _init(SearchEvent event, Emitter<SearchState> emit) {}

  void _onActivateManual(OnActivateManualMarkerEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(displayManualMarker: event.isActive));
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
}
