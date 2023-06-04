import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas/models/trafic_response.dart';
import 'package:mapas/services/trafict_insterseptor.dart';

class TrafictServices {
  final Dio _dioTrafic;
  final String urlTraficUrl = 'https://api.mapbox.com/directions/v5/mapbox';

  TrafictServices() : _dioTrafic = Dio()..interceptors.add(TrafictInterceptor());

  Future<TraficResponse> getCoordStartToEnd(LatLng start, LatLng end) async {
    final coorsString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$urlTraficUrl/driving/$coorsString';

    final result = await _dioTrafic.get(url);
    final data = TraficResponse.fromMap(result.data);
    return data;
  }
}
