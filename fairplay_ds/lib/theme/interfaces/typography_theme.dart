import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

import 'mapper_theme.dart';

enum CoreTextType {
  headline1,
  headline2,
  headline3,
  headline4,
  headline5,
  headline6,
  bodyText1,
  bodyText1Normal,
  bodyText2,
  bodyText2Normal,
  label,
  caption,
}

@CopyWith()
class CoreTypographyTheme extends ThemeExtension<CoreTypographyTheme>
    with MapperThemeBehavior<CoreTypographyTheme> {
  CoreTypographyTheme({
    required this.values,
  });

  final Map<CoreTextType, TextStyle> values;
}
