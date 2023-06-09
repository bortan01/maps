import 'package:dio/dio.dart';

const accesToken = "pk.eyJ1IjoiZmVybmFuZG9tb3ZpZSIsImEiOiJjazkwOTh3ZXQwMHR4M2RsOGdzdndxaHJ5In0.89mGTKByzDk2_c4kduxfGw";

class PlacesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      "access_token": accesToken,
      'language' : 'es',
      'autocomplete' : true,
    });
    super.onRequest(options, handler);
  }
}
