import 'package:flutter/material.dart';

/// This is just a customPainter class for linear progress bar
class CustomLoadingLinearPainter extends CustomPainter {
  final double progress;
  final Color loadingColor;
  final Color strokeColor;
  final Color backGroundColor;
  CustomLoadingLinearPainter(
      {required this.progress,
      required this.loadingColor,
      required this.backGroundColor,
      required this.strokeColor});
  @override
  void paint(Canvas canvas, Size size) {
    var Size(:width, :height) = size;

    // paint for the border stroke
    Paint strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = height * 0.1;

    // paint for the fill
    Paint fillPaint = Paint()..color = loadingColor;

    // draw of the bar border
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(0, 0, width, height), Radius.circular(width * 0.1)),
        strokePaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(0, 0, width, height), Radius.circular(width * 0.1)),
        Paint()..color = backGroundColor);
    // draw of the progress
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTRB(0, 0, progress, height),
            Radius.circular(width * 0.1)),
        fillPaint);
  }

  @override
  bool shouldRepaint(CustomLoadingLinearPainter oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(CustomLoadingLinearPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
