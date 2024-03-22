import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_loading_animation/custom_progress_bar_widget.dart';
import 'package:flutter_loading_animation/loading_circle_paint.dart';
import 'package:flutter_loading_animation/loading_linear_paint.dart';

class CustomLoadingWidget extends StatefulWidget {
  final double size;
  final bool showLoadingInDigit;
  final Color loadingStartColor;
  final Color loadingEndColor;
  final Color strokeColor;
  final Duration durationToComplete;
  final Color textColor;
  final ProgressBarStyle progressBarStyle;
  final int totalProgressValue;
  final int completedProgressValue;
  final Color backGroundColor;
  const CustomLoadingWidget({
    super.key,
    required this.size,
    required this.textColor,
    required this.strokeColor,
    required this.backGroundColor,
    required this.showLoadingInDigit,
    required this.loadingStartColor,
    required this.loadingEndColor,
    required this.durationToComplete,
    required this.progressBarStyle,
    required this.completedProgressValue,
    required this.totalProgressValue,
  });

  @override
  State<CustomLoadingWidget> createState() => _CustomLoadingWidgetState();
}

/// here I used stateful widget to manage all the animations
/// also which custom painter should be used here I decides

class _CustomLoadingWidgetState extends State<CustomLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController loadingController;
  late Animation<double> loadingCircularAnimation;
  late Animation<double> loadingLinearAnimation;
  late Animation<int> textAnimation;
  late Animation<Color?> colorAnimation;

  late double linearProgressBarWidth;
  late double givenPercentFillWidth;
  late double circularGivenPercentArcWidth;
  @override
  void initState() {
    super.initState();
    linearProgressBarWidth = widget.size * 4;
    givenPercentFillWidth =
        (linearProgressBarWidth / widget.totalProgressValue) *
            widget.completedProgressValue;
    circularGivenPercentArcWidth =
        (degreeToRadian(360) / widget.totalProgressValue) *
            widget.completedProgressValue;
    loadingController = AnimationController(
      vsync: this,
      duration: widget.durationToComplete,
    )..addListener(() {
        setState(() {});
      });

    // tween for linear progress bar
    final Tween<double> linearProgressTween =
        Tween<double>(begin: 0, end: givenPercentFillWidth);
    // tween for circular progress bar
    final Tween<double> circularProgressTween = Tween<double>(
        begin: degreeToRadian(0), end: circularGivenPercentArcWidth);
    // tween for the color change in both progress bars
    final ColorTween colorTweenForProgress = ColorTween(
        begin: widget.loadingStartColor, end: widget.loadingEndColor);
    // tween for the text update in both progress bars
    final IntTween textTweenForProgress =
        IntTween(begin: 0, end: widget.completedProgressValue);

    loadingLinearAnimation = linearProgressTween.animate(loadingController);
    loadingCircularAnimation = circularProgressTween.animate(loadingController);
    colorAnimation = colorTweenForProgress.animate(loadingController);
    textAnimation = textTweenForProgress.animate(loadingController);
  }

  double degreeToRadian(int degree) {
    return degree * pi / 180;
  }

  bool isReset = false;
  void onPressed() {
    if (isReset) {
      loadingController.reset();

      isReset = false;
    } else {
      loadingController.forward();
      isReset = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Builder(builder: (context) {
          return widget.progressBarStyle == ProgressBarStyle.circular
              // custom widget if the selected style is circular
              ? CustomPaint(
                  painter: CustomLoadingCirclePainter(
                      backGroundColor: widget.backGroundColor,
                      strokeColor: widget.strokeColor,
                      sweepAngle: loadingCircularAnimation.value,
                      loadingColor: colorAnimation.value!),
                  child: SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: InkWell(
                      onTap: onPressed,
                    ),
                  ),
                )
              // custom widget if the selected style is linear
              : CustomPaint(
                  painter: CustomLoadingLinearPainter(
                      progress: loadingLinearAnimation.value,
                      strokeColor: widget.strokeColor,
                      backGroundColor: widget.backGroundColor,
                      loadingColor: colorAnimation.value!),
                  child: SizedBox(
                    height: widget.size,
                    width: linearProgressBarWidth,
                    child: InkWell(
                      onTap: onPressed,
                    ),
                  ),
                );
        }),

        // progress update in text if user selected {showLoadingInDigit} as true
        widget.showLoadingInDigit
            ? Text(
                '${textAnimation.value}%',
                style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.size * 0.2,
                    fontWeight: FontWeight.bold),
              )
            : const SizedBox(),
      ],
    );
  }
}
