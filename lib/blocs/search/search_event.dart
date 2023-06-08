part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateMarkers extends SearchEvent {
  final bool showButtonDestination;
  final bool showMarker;
  final bool showButtonBack;
  const OnUpdateMarkers({
    required this.showButtonDestination,
    required this.showMarker,
    required this.showButtonBack,
    required bool isActive,
  });
}

class OnNewPlaceFoundEvent extends SearchEvent {
  final List<Feature> places;
  const OnNewPlaceFoundEvent({
    required this.places,
  });
}

class AddToHistoryEvent extends SearchEvent {
  final Feature place;

  const AddToHistoryEvent({required this.place});
}
