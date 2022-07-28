import 'package:flutter/material.dart';

import 'mapper_theme.dart';

enum CoreBorderRadiusType {
  small,
  medium,
  large,
  circular,
}

class CoreBorderRadiusTheme extends ThemeExtension<CoreBorderRadiusTheme>
    with MapperThemeBehavior<CoreBorderRadiusTheme> {
  CoreBorderRadiusTheme({
    required this.values,
  });

  final Map<CoreBorderRadiusType, double> values;
}
