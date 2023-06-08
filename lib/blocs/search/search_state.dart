part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool showButtonDestination;
  final bool showMarker;
  final bool showButtonBack;
  final List<Feature> places;
  final List<Feature> history;
  const SearchState({
    this.showButtonDestination = false,
    this.showMarker = false,
    this.showButtonBack = false,
    this.places = const [],
    this.history = const [],
  });

  SearchState copyWith({
    bool? showButtonDestination,
    bool? showMarker,
    bool? showButtonBack,
    List<Feature>? places,
    List<Feature>? history,
  }) {
    return SearchState(
      showButtonDestination: showButtonDestination ?? this.showButtonDestination,
      showMarker: showMarker ?? this.showMarker,
      showButtonBack: showButtonBack ?? this.showButtonBack,
      places: places ?? this.places,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props {
    return [
      showButtonDestination,
      showMarker,
      showButtonBack,
      places,
      history,
    ];
  }
}
