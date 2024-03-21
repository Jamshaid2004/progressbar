import 'package:flutter/material.dart';

class CustomLoadingCirclePainter extends CustomPainter {
  double sweepAngle;
  Color loadingColor;
  Color strokeColor;
  CustomLoadingCirclePainter(
      {required this.sweepAngle,
      required this.loadingColor,
      required this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    var Size(:width, :height) = size;
    var radius = width < height ? width / 2 : height / 2;
    var center = Offset(width / 2, height / 2);
    Paint loadingPaint = Paint()
      ..color = loadingColor
      ..strokeWidth = radius * 0.2
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    Paint strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.01;
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(center, radius, strokePaint);
    canvas.drawCircle(center, radius + (radius * 0.1), strokePaint);
    canvas.drawArc(rect, 0, sweepAngle, true, loadingPaint);
    canvas.drawCircle(center, radius, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomLoadingCirclePainter oldDelegate) =>
      oldDelegate.sweepAngle != sweepAngle;

  @override
  bool shouldRebuildSemantics(CustomLoadingCirclePainter oldDelegate) =>
      oldDelegate.sweepAngle != sweepAngle;
}
