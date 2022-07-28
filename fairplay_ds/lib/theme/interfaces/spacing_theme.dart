import 'package:flutter/material.dart';
import 'mapper_theme.dart';

enum CoreSpacingType {
  none,
  tiny,
  small,
  medium,
  large,
  huge,
}

class CoreSpacingTheme extends ThemeExtension<CoreSpacingTheme>
    with MapperThemeBehavior<CoreSpacingTheme> {
  CoreSpacingTheme({
    required this.values,
  });

  final Map<CoreSpacingType, double> values;
}
