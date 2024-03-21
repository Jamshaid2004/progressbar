import 'package:flutter/material.dart';
/// This is just a customPainter class for circular progress bar
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
    // center of the circle
    var center = Offset(width / 2, height / 2);
    // paint for the progress 
    Paint loadingPaint = Paint()
      ..color = loadingColor
      ..strokeWidth = radius * 0.2
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    // paint for the stroke border
    Paint strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.01; 
    // rect for the progress arc  
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    // draw of stroke
    canvas.drawCircle(center, radius, strokePaint);
    canvas.drawCircle(center, radius + (radius * 0.1), strokePaint);
    // draw of progress or fill
    canvas.drawArc(rect, 0, sweepAngle, true, loadingPaint);
    // draw of a white circle to hide inner arc
    canvas.drawCircle(center, radius, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomLoadingCirclePainter oldDelegate) =>
      oldDelegate.sweepAngle != sweepAngle;

  @override
  bool shouldRebuildSemantics(CustomLoadingCirclePainter oldDelegate) =>
      oldDelegate.sweepAngle != sweepAngle;
}
