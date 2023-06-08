import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final bool cancel;
  final bool manual;
  final bool showMarke;
  final bool showButtonBack;
  final bool showButtonDestination;
  final LatLng? position;
  final String name;
  final String description;

  SearchResult({
    required this.cancel,
    required this.manual,
    required this.showMarke,
    required this.showButtonBack,
    required this.showButtonDestination,
    this.position,
    required this.name,
    required this.description,
  });

  SearchResult copyWith({
    bool? cancel,
    bool? manual,
    bool? showMarke,
    bool? showButtonBack,
    bool? showButtonDestination,
    LatLng? position,
    String? name,
    String? description,
  }) {
    return SearchResult(
      cancel: cancel ?? this.cancel,
      manual: manual ?? this.manual,
      showMarke: showMarke ?? this.showMarke,
      showButtonBack: showButtonBack ?? this.showButtonBack,
      showButtonDestination: showButtonDestination ?? this.showButtonDestination,
      position: position ?? this.position,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  String toString() => 'SearchResult(cancel: $cancel, manual: $manual)';
}
