import 'package:dio/dio.dart';

const accesToken = "pk.eyJ1IjoiZmVybmFuZG9tb3ZpZSIsImEiOiJjazkwOTh3ZXQwMHR4M2RsOGdzdndxaHJ5In0.89mGTKByzDk2_c4kduxfGw";

class TrafictInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      "alternatives": "true",
      "geometries": "polyline6",
      "overview": "simplified",
      "steps": "false",
      "access_token": accesToken
    });
    super.onRequest(options, handler);
  }
}
