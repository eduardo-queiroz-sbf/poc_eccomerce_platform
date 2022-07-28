import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:flutter/material.dart';

import 'mapper_theme.dart';

class CoreStepperThemeData {
  CoreStepperThemeData({
    required this.colorLineCompletedProgress,
    required this.colorLineRemainingProgress,
    required this.progressStyle,
    required this.titleStyle,
  });

  final CoreColorType colorLineCompletedProgress;
  final CoreColorType colorLineRemainingProgress;
  final TextStyle progressStyle;
  final TextStyle titleStyle;
}

class CoreStepperTheme extends ThemeExtension<CoreStepperTheme>
    with MapperThemeBehavior<CoreStepperTheme> {
  CoreStepperTheme({
    required this.values,
  });

  final CoreStepperThemeData values;
}
