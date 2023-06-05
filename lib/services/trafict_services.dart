import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas/models/places_response.dart';
import 'package:mapas/models/trafic_response.dart';
import 'package:mapas/services/places_interceptor.dart';
import 'package:mapas/services/trafict_insterseptor.dart';

class TraficServices {
  final Dio _dioTrafic;
  final String urlTraficUrl = 'https://api.mapbox.com/directions/v5/mapbox';

  TraficServices() : _dioTrafic = Dio()..interceptors.add(TraficInterceptor());

  Future<TraficResponse> getCoordStartToEnd(LatLng start, LatLng end) async {
    final coorsString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$urlTraficUrl/driving/$coorsString';

    final result = await _dioTrafic.get(url);
    final data = TraficResponse.fromMap(result.data);
    return data;
  }

  Future<List<Feature>> getResultByQuery(String query, LatLng proximity) async {
    final Dio dioPlaces = Dio();
    dioPlaces.interceptors.add(PlacesInterceptor());
    if (query.isEmpty) return [];
    final url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json';
    final resp =
        await dioPlaces.get(url, queryParameters: {'proximity': '${proximity.longitude},${proximity.latitude}'});
    final placesResponse = PlacesResponse.fromMap(resp.data);
    return placesResponse.features;
  }
}
