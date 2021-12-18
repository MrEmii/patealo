import 'package:flutter/material.dart';
import 'package:patealo/presentation/theme.dart';

class WavePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset((size.width / 2) - 100, 100), size.width, paint);

    paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(400, 200), size.width * .8, paint);

    paint = Paint()
      ..color = AppTheme.primaryColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, 500), size.width , paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}