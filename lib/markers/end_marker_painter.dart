import 'package:flutter/material.dart';

class EndMarkerPainter extends CustomPainter {
  final int kilometros;
  final String destination;
  EndMarkerPainter({
    required this.kilometros,
    required this.destination,
  });
  @override
  void paint(Canvas canvas, Size size) {
    const double circleBlackRadius = 20.0;
    const double circleWhiteRadius = 7;

    final blckPaint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;
    // CIRCULO NEGRO
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height - circleBlackRadius),
      circleBlackRadius,
      blckPaint,
    );

    // CIRCULO BLANCO
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    // DIBUJANDO UNA CAJA BLANCA
    final path = Path();
    path.moveTo(10, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(10, 100);
    // SOMBRA DE LA CAJA
    canvas.drawShadow(path, Colors.black, 10, false);

    canvas.drawPath(path, whitePaint);

    // CAJA NEGRA
    const blackBox = Rect.fromLTWH(10, 20, 70, 80);
    canvas.drawRect(blackBox, blckPaint);

    // TEXTOS Y MINUTOS
    final textSpan = TextSpan(
        text: kilometros.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w400,
        ));

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );
    minutesPainter.paint(canvas, const Offset(10, 35));

    // PALABRA MIN

    // TEXTOS Y MINUTOS
    const minutsText = TextSpan(
        text: 'Kms',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ));

    final minutesMinPainter = TextPainter(
      text: minutsText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );
    minutesMinPainter.paint(canvas, const Offset(10, 68));

    // DESCRIPCION
    final locationTExt = TextSpan(
        text: destination,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ));

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationTExt,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
        minWidth: size.width - 100,
        maxWidth: size.width - 100,
      );
    double offsetY = destination.length > 20 ? 34 : 40;
    locationPainter.paint(canvas, Offset(90, offsetY));
  }

  @override
  bool shouldRepaint(EndMarkerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(EndMarkerPainter oldDelegate) => false;
}
//39.90 
//36.00
//11.38 96