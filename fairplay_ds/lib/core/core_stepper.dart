import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/theme/interfaces/stepper_theme.dart';
import 'package:flutter/material.dart';

class CoreStepperData {
  final double completedProgress;

  CoreStepperData({
    required this.completedProgress,
  });
}

class CoreStepper extends StatelessWidget {
  final String title;
  final int maxSteps;
  final int currentStep;
  final bool hideProgressLabel;
  final CoreSpacing? margin;
  final CoreSpacing? padding;

  const CoreStepper({
    required this.title,
    required this.maxSteps,
    required this.currentStep,
    this.hideProgressLabel = false,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    CoreStepperTheme? coreStepperTheme;

    if (Theme.of(context)
        .extensions
        .values
        .whereType<CoreStepperTheme>()
        .isNotEmpty) {
      coreStepperTheme = Theme.of(context).extension<CoreStepperTheme>();
    }

    bool _isComplete = _progressCompleted();
    CoreStepperData _steps = _calcStepSize(MediaQuery.of(context).size.width);

    return CoreContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CoreContainer(
                height: 2,
                width: _steps.completedProgress,
                color: coreStepperTheme != null
                    ? coreStepperTheme.values.colorLineCompletedProgress
                    : null,
              ),
              if (!_isComplete)
                Expanded(
                  child: CoreContainer(
                    height: 2,
                    width: double.maxFinite,
                    color: coreStepperTheme != null
                        ? coreStepperTheme.values.colorLineRemainingProgress
                        : null,
                  ),
                ),
            ],
          ),
          CoreContainer(
            margin: margin,
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !hideProgressLabel,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 32),
                    child: Text(
                      'Passo ${currentStep.toString()} de ${maxSteps.toString()}',
                      style: coreStepperTheme != null
                          ? coreStepperTheme.values.progressStyle
                          : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    title,
                    style: coreStepperTheme != null
                        ? coreStepperTheme.values.titleStyle
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _progressCompleted() {
    return currentStep >= maxSteps;
  }

  CoreStepperData _calcStepSize(double maxWidth) {
    double _sizeStep = maxWidth / maxSteps;
    double _completedSteps = _sizeStep * currentStep;

    return CoreStepperData(completedProgress: _completedSteps);
  }
}
