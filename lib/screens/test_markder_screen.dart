import 'package:flutter/material.dart';

import '../markers/end_marker_painter.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          height: 150,
          width: 350,
          child: CustomPaint(
            painter: EndMarkerPainter(
                destination: 'Consectetur in voluptate irure voluptate enim dolore id.', kilometros: 86),
          ),
        ),
      ),
    );
  }
}
