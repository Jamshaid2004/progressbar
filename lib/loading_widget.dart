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
  const CustomLoadingWidget({
    super.key,
    required this.size,
    required this.textColor,
    required this.strokeColor,
    required this.showLoadingInDigit,
    required this.loadingStartColor,
    required this.loadingEndColor,
    required this.durationToComplete,
    required this.progressBarStyle,
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
  @override
  void initState() {
    super.initState();
    loadingController = AnimationController(
      vsync: this,
      duration: widget.durationToComplete,
    )..addListener(() {
        setState(() {});
      });

    // tween for linear progress bar
    final Tween<double> linearProgressTween =
        Tween<double>(begin: 0, end: widget.size * 4);
    // tween for circular progress bar
    final Tween<double> circularProgressTween =
        Tween<double>(begin: 0, end: 2 * pi);
    // tween for the color change in both progress bars
    final ColorTween colorTweenForProgress = ColorTween(
        begin: widget.loadingStartColor, end: widget.loadingEndColor);
    // tween for the text update in both progress bars
    final IntTween textTweenForProgress = IntTween(begin: 0, end: 100);

    loadingLinearAnimation = linearProgressTween.animate(loadingController);
    loadingCircularAnimation = circularProgressTween.animate(loadingController);
    colorAnimation = colorTweenForProgress.animate(loadingController);
    textAnimation = textTweenForProgress.animate(loadingController);
  }

  void onPressed() {
    bool isReset = false;
    loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        loadingController.reset();
        isReset = true;
      }
    });
    if (!isReset) {
      loadingController.forward();
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
                      loadingColor: colorAnimation.value!),
                  child: SizedBox(
                    height: widget.size,
                    width: widget.size * 4,
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
