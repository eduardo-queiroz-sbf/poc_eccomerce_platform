import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/typography_theme.dart';
import 'package:flutter/material.dart';

class CoreTypography extends StatelessWidget {
  const CoreTypography(
    this.content, {
    this.type,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.bodyText1(
    this.content, {
    this.type = CoreTextType.bodyText1,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.bodyText2(
    this.content, {
    this.type = CoreTextType.bodyText2,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.headline1(
    this.content, {
    this.type = CoreTextType.headline1,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.headline2(
    this.content, {
    this.type = CoreTextType.headline2,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.headline3(
    this.content, {
    this.type = CoreTextType.headline3,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.headline4(
    this.content, {
    this.type = CoreTextType.headline4,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.headline5(
    this.content, {
    this.type = CoreTextType.headline5,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.headline6(
    this.content, {
    this.type = CoreTextType.headline6,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.bodyText1Normal(
    this.content, {
    this.type = CoreTextType.bodyText1Normal,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.bodyText2Normal(
    this.content, {
    this.type = CoreTextType.bodyText2Normal,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.label(
    this.content, {
    this.type = CoreTextType.label,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });
  const CoreTypography.caption(
    this.content, {
    this.type = CoreTextType.caption,
    this.textStyle,
    this.maxLength = 0,
    this.textAlign = TextAlign.left,
    this.color = CoreColorType.neutralBlack,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
  });

  //custom style
  final TextStyle? textStyle;
  final CoreTextType? type;
  final TextAlign? textAlign;
  final String content;
  final CoreColorType? color;
  final int maxLength;
  final TextDecoration decoration;
  final int? maxLines;
  final TextOverflow? overflow;

  TextStyle _getThemedStyle(BuildContext context) {
    Color currentColor =
        Theme.of(context).extension<CoreColorTheme>()!.values[color]!;
    TextStyle currentStyle =
        Theme.of(context).extension<CoreTypographyTheme>()!.values[type] ??
            TextStyle();

    return currentStyle.merge(textStyle).merge(
          TextStyle(
            color: currentColor,
            decoration: decoration,
          ),
        );
  }

  String _formatMaxLength() {
    String textResult = content;

    if (maxLength > 0 && content.length > maxLength) {
      final String splitTextOnMaxLength = content.substring(0, maxLength);
      textResult = '$splitTextOnMaxLength...';
    }

    return textResult;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle currentStyle = _getThemedStyle(context);

    return Text(
      _formatMaxLength(),
      style: currentStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
