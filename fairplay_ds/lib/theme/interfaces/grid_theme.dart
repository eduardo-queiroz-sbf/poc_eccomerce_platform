import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';
import 'package:fairplay_ds/theme/interfaces/mapper_theme.dart';

enum CoreGridSizeType {
  small("small"),
  medium("medium"),
  large("large"),
  xlarge("xlarge");

  final String name;
  const CoreGridSizeType(this.name);
}

class CoreGridThemeData {
  CoreGridThemeData({
    required this.columns,
    required this.padding,
    required this.margin,
  });

  final double columns;
  final CoreSpacingTheme padding;
  final CoreSpacingTheme margin;
}

class CoreGridTheme extends ThemeExtension<CoreGridTheme>
    with MapperThemeBehavior<CoreGridTheme> {
  CoreGridTheme({
    required this.values,
  });

  final Map<CoreGridSizeType, CoreGridThemeData> values;
}
