import 'package:flutter/material.dart';

class CustomLoadingLinearPainter extends CustomPainter {
  
  final double progress;
  final Color loadingColor;
  final Color strokeColor;
  CustomLoadingLinearPainter({required this.progress,required this.loadingColor,required this.strokeColor});
  @override
  void paint(Canvas canvas, Size size) {
    var Size(:width, :height) = size;
    Paint strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = height * 0.1;
    Paint fillPaint = Paint()..color = loadingColor;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(0, 0, progress, height), Radius.circular(width * 0.1)),
        fillPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(0, 0, width, height), Radius.circular(width * 0.1)),
        strokePaint);
  }

  @override
  bool shouldRepaint(CustomLoadingLinearPainter oldDelegate) => oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(CustomLoadingLinearPainter oldDelegate) => oldDelegate.progress != progress;
}
