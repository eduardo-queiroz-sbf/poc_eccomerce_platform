import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/progress_indicator_theme.dart';
import 'package:flutter/material.dart';

class CoreProgressIndicator extends StatelessWidget {
  const CoreProgressIndicator({
    Key? key,
    required this.type,
    this.color,
    this.isVisible = true,
  }) : super(key: key);

  const CoreProgressIndicator.small({
    Key? key,
    this.color,
    this.isVisible = true,
  })  : type = CoreProgressIndicatorType.small,
        super(key: key);

  const CoreProgressIndicator.medium({
    Key? key,
    this.color,
    this.isVisible = true,
  })  : type = CoreProgressIndicatorType.medium,
        super(key: key);

  const CoreProgressIndicator.large({
    Key? key,
    this.color,
    this.isVisible = true,
  })  : type = CoreProgressIndicatorType.large,
        super(key: key);

  final bool isVisible;
  final CoreProgressIndicatorType type;
  final CoreColorType? color;

  CoreProgressIndicatorThemeData _getThemedStyle(BuildContext context) {
    CoreProgressIndicatorThemeData currentStyle = Theme.of(context)
            .extension<CoreProgressIndicatorTheme>()!
            .values[this.type] ??
        CoreProgressIndicatorThemeData.defaultInstance();
    currentStyle.color = Theme.of(context)
        .extension<CoreColorTheme>()!
        .values[color ?? currentStyle.colorType];
    return currentStyle;
  }

  @override
  Widget build(BuildContext context) {
    CoreProgressIndicatorThemeData currentStyle = _getThemedStyle(context);
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: currentStyle.size,
        height: currentStyle.size,
        child: CircularProgressIndicator(
          backgroundColor: currentStyle.backgroundColor,
          strokeWidth: currentStyle.strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(currentStyle.color!),
        ),
      ),
    );
  }
}
