import 'package:flutter/material.dart';

class StartMakerPainter extends CustomPainter {
    final int minutes;
    final String destination;
  StartMakerPainter({
    required this.minutes,
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
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleBlackRadius,
      blckPaint,
    );

    // CIRCULO BLANCO
    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    // DIBUJANDO UNA CAJA BLANCA
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    // SOMBRA DE LA CAJA
    canvas.drawShadow(path, Colors.black, 10, false);

    canvas.drawPath(path, whitePaint);

    // CAJA NEGRA
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blckPaint);

    // TEXTOS Y MINUTOS
    final textSpan = TextSpan(
        text: minutes.toString(),
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
    minutesPainter.paint(canvas, const Offset(40, 35));

    // PALABRA MIN

    // TEXTOS Y MINUTOS
    const minutsText = TextSpan(
        text: 'Min',
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
    minutesMinPainter.paint(canvas, const Offset(40, 68));

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
        minWidth: size.width - 135,
        maxWidth: size.width - 135,
      );
    double offsetY = destination.length > 20 ? 34 : 40;
    locationPainter.paint(canvas, Offset(120, offsetY));
  }

  @override
  bool shouldRepaint(StartMakerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(StartMakerPainter oldDelegate) => false;
}
//39.90 
//36.00
//11.38 96