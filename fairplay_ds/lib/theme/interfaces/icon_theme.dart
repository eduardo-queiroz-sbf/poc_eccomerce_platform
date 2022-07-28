import 'package:flutter/material.dart';

import 'mapper_theme.dart';

enum CoreIconSizeType {
  none,
  tiny,
  small,
  medium,
  large,
  huge,
}

class CoreIconSizeTheme extends ThemeExtension<CoreIconSizeTheme>
    with MapperThemeBehavior<CoreIconSizeTheme> {
  CoreIconSizeTheme({
    required this.values,
  });

  final Map<CoreIconSizeType, double> values;
}
