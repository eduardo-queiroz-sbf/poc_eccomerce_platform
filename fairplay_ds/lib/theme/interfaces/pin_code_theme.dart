import 'package:flutter/material.dart';

import 'mapper_theme.dart';

class CorePinCodeThemeData {
  CorePinCodeThemeData({
    this.focusedBorder,
    this.border,
    this.valueStyle,
  });

  final InputBorder? focusedBorder;
  final InputBorder? border;
  final TextStyle? valueStyle;
}

class CorePinCodeTheme extends ThemeExtension<CorePinCodeTheme>
    with MapperThemeBehavior<CorePinCodeTheme> {
  CorePinCodeTheme({
    required this.value,
  });

  final CorePinCodeThemeData value;
}
