import 'package:flutter/material.dart';

import 'mapper_theme.dart';

enum CoreColorType {
  //brand colors
  primary,
  secondary,
  // alert colors
  alert,
  alertLightest,
  alertDark,
  // informative colors
  informative,
  informativeLightest,
  informativeDark,
  // error colors
  error,
  errorLightest,
  errorDark,
  // success colors
  success,
  successLightest,
  successDark,
  // neutral colors
  neutralBlack,
  neutralWhite,
  neutral200,
  neutral300,
  neutral400,
  neutral500,
  neutral600,
  // overlay
  overlay
}

class CoreColorTheme extends ThemeExtension<CoreColorTheme>
    with MapperThemeBehavior<CoreColorTheme> {
  CoreColorTheme({
    required this.values,
  });

  final Map<CoreColorType, Color> values;
}
