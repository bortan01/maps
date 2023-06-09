import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas/markers/end_marker_painter.dart';
import 'package:mapas/markers/star_marker_painter.dart';

Future<BitmapDescriptor> getStartCusmtomMarker({required int minutes,required String destination}) async {
  final record = ui.PictureRecorder();
  final canvas = ui.Canvas(record);

  const size = ui.Size(350, 150);
  final startMarker = StartMakerPainter(minutes: minutes, destination: destination);
  startMarker.paint(canvas, size);
  final picture = record.endRecording();
  final imaage = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteDate = await imaage.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(byteDate!.buffer.asUint8List());
}

Future<BitmapDescriptor> getEndCusmtomMarker({required int kilometros,required String destination}) async {
  final record = ui.PictureRecorder();
  final canvas = ui.Canvas(record);

  const size = ui.Size(350, 150);
  final startMarker = EndMarkerPainter(kilometros: kilometros, destination: destination);
  startMarker.paint(canvas, size);
  final picture = record.endRecording();
  final imaage = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteDate = await imaage.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(byteDate!.buffer.asUint8List());
}
