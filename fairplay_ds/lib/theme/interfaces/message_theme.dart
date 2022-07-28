import 'package:flutter/material.dart';
import 'color_theme.dart';
import 'mapper_theme.dart';

enum CoreMessageType {
  error,
  success,
}

class CoreMessageThemeData {
  CoreMessageThemeData({
    required this.path,
    required this.colorType,
    required this.textStyle,
  });

  CoreMessageThemeData.defaultInstance({
    this.path,
    this.colorType = CoreColorType.neutral600,
    this.textStyle = const TextStyle(),
  });

  final String? path;
  final CoreColorType colorType;
  late Color? color;
  final TextStyle textStyle;
}

class CoreMessageTheme extends ThemeExtension<CoreMessageTheme>
    with MapperThemeBehavior<CoreMessageTheme> {
  CoreMessageTheme({
    required this.values,
  });

  final Map<CoreMessageType, CoreMessageThemeData> values;
}
