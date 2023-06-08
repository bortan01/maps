part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;
  final bool showMarker;
  final List<Feature> places;
  final List<Feature> history;
  const SearchState({
    this.displayManualMarker = false,
    this.showMarker = true,
    this.places = const [],
    this.history = const [],
  });

  SearchState copyWith({
    bool? displayManualMarker,
    bool? showMarker,
    List<Feature>? places,
    List<Feature>? history,
  }) {
    return SearchState(
      displayManualMarker: displayManualMarker ?? this.displayManualMarker,
      showMarker: showMarker ?? this.showMarker,
      places: places ?? this.places,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props => [displayManualMarker, showMarker, places, history];
}
