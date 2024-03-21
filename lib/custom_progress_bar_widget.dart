import 'package:flutter/material.dart';
import 'package:flutter_loading_animation/loading_widget.dart';

enum ProgressBarStyle { linear, circular }
/// widget for user to user and consume
/// enumeration of [ProgressBarStyle] decides the custom painter to be used
/// every property can be handled through this stateless widget
/// every parameter contains its default value so user can use this widget without even giving any value
/// also user can modify any value as per requirement
class CustomProgressBarWidget extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Duration durationToComplete;
  final ProgressBarStyle progressBarStyle;
  final Color strokeColor;
  final bool showProgressInDigit;
  final double size;
  final Color textColor;

  const CustomProgressBarWidget({
    super.key,
    this.startColor = Colors.red,
    this.endColor = Colors.green,
    this.durationToComplete = const Duration(seconds: 10),
    this.progressBarStyle = ProgressBarStyle.linear,
    this.strokeColor = Colors.black,
    this.showProgressInDigit = true,
    this.textColor = Colors.black,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoadingWidget(
        size: size,
        textColor: textColor,
        strokeColor: strokeColor,
        showLoadingInDigit: showProgressInDigit,
        loadingStartColor: startColor,
        loadingEndColor: endColor,
        durationToComplete: durationToComplete,
        progressBarStyle: progressBarStyle);
  }
}
