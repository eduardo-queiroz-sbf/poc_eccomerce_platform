import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';

class CoreWrap extends StatelessWidget {
  const CoreWrap({
    this.key,
    required this.children,
    this.textDirection,
    this.spacingType,
    this.runSpacingType,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  final Key? key;
  final Axis direction = Axis.horizontal;
  final WrapAlignment alignment;
  final CoreSpacingType? spacingType;
  final WrapAlignment runAlignment;
  final CoreSpacingType? runSpacingType;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final Clip clipBehavior = Clip.none;
  final List<Widget> children;

  double getRunSpacing(BuildContext context) {
    if (runSpacingType != null) {
      return Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[runSpacingType] ??
          0.0;
    }
    return 0.0;
  }

  double getSpacing(BuildContext context) {
    if (spacingType != null) {
      return Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[spacingType] ??
          0.0;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final runSpacing = getRunSpacing(context);
    final spacing = getSpacing(context);

    return Wrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: children,
      clipBehavior: clipBehavior,
    );
  }
}
