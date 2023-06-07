part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchEvent {
  final bool isActive;

  const OnActivateManualMarkerEvent({required this.isActive});
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