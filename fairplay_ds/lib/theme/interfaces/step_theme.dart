import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:flutter/material.dart';

import 'mapper_theme.dart';

enum CoreStepType {
  disabled,
  active,
  error,
}

class CoreStepThemeData {
  CoreStepThemeData({
    required this.color,
    required this.colorLine,
    required this.path,
    required this.titleStyle,
    required this.labelStyle,
  });

  final dynamic path;
  final CoreColorType color;
  final CoreColorType colorLine;
  final TextStyle titleStyle;
  final TextStyle labelStyle;
}

class CoreStepTheme extends ThemeExtension<CoreStepTheme>
    with MapperThemeBehavior<CoreStepTheme> {
  CoreStepTheme({
    required this.values,
  });

  final Map<CoreStepType, CoreStepThemeData> values;
}
