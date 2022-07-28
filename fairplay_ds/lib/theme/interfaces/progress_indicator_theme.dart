import 'package:flutter/material.dart';

import 'color_theme.dart';
import 'mapper_theme.dart';

enum CoreProgressIndicatorType {
  small,
  medium,
  large,
}

class CoreProgressIndicatorThemeData {
  CoreProgressIndicatorThemeData({
    required this.size,
    required this.strokeWidth,
    required this.colorType,
    required this.backgroundColor,
  });

  CoreProgressIndicatorThemeData.defaultInstance({
    this.size = 30,
    this.strokeWidth = 2,
    this.colorType = CoreColorType.neutral600,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
  });

  final double size;
  final double strokeWidth;
  final CoreColorType colorType;
  late Color? color;
  final Color backgroundColor;
}

class CoreProgressIndicatorTheme
    extends ThemeExtension<CoreProgressIndicatorTheme>
    with MapperThemeBehavior<CoreProgressIndicatorTheme> {
  CoreProgressIndicatorTheme({
    required this.values,
  });

  final Map<CoreProgressIndicatorType, CoreProgressIndicatorThemeData> values;
}
