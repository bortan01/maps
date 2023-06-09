import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getAssetImageMarket() async {
  return BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(devicePixelRatio: 2.5),
    'assets/custom-pin.png',
  );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final response = await Dio().get('https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options(responseType: ResponseType.bytes));

  final imageCode = await ui.instantiateImageCodec(response.data, targetHeight: 150, targetWidth: 150);
  final frame = await imageCode.getNextFrame();
  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
  if (data == null) {
    return await getAssetImageMarket();
  }

  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}