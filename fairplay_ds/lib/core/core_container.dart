import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/radius_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';

class CoreSpacing {
  const CoreSpacing(
      {CoreSpacingType? all,
      CoreSpacingType? horizontal,
      CoreSpacingType? vertical,
      CoreSpacingType? top,
      CoreSpacingType? bottom,
      CoreSpacingType? left,
      CoreSpacingType? right})
      : this.all = all ?? CoreSpacingType.none,
        this.horizontal = all ?? horizontal ?? CoreSpacingType.none,
        this.vertical = all ?? vertical ?? CoreSpacingType.none,
        this.top = all ?? vertical ?? top ?? CoreSpacingType.none,
        this.bottom = all ?? vertical ?? bottom ?? CoreSpacingType.none,
        this.left = all ?? horizontal ?? left ?? CoreSpacingType.none,
        this.right = all ?? horizontal ?? right ?? CoreSpacingType.none;

  final CoreSpacingType all;
  final CoreSpacingType horizontal;
  final CoreSpacingType vertical;
  final CoreSpacingType left;
  final CoreSpacingType right;
  final CoreSpacingType top;
  final CoreSpacingType bottom;
}

class CoreContainer extends StatelessWidget {
  const CoreContainer({
    Key? key,
    this.child,
    this.margin,
    this.padding,
    this.visible = true,
    this.bordered = false,
    this.color,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.radius = false,
    this.borderColor = CoreColorType.neutral300,
  }) : super(key: key);

  const CoreContainer.tiny({
    Key? key,
    this.child,
    this.margin,
    this.padding = const CoreSpacing(all: CoreSpacingType.tiny),
    this.visible = true,
    this.bordered = false,
    this.color,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.radius = false,
    this.borderColor = CoreColorType.neutral300,
  }) : super(key: key);

  const CoreContainer.small({
    Key? key,
    this.child,
    this.margin,
    this.padding = const CoreSpacing(all: CoreSpacingType.small),
    this.visible = true,
    this.bordered = false,
    this.color,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.radius = false,
    this.borderColor = CoreColorType.neutral300,
  }) : super(key: key);

  const CoreContainer.medium({
    Key? key,
    this.child,
    this.margin,
    this.padding = const CoreSpacing(all: CoreSpacingType.small),
    this.visible = true,
    this.bordered = false,
    this.color,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.radius = false,
    this.borderColor = CoreColorType.neutral300,
  }) : super(key: key);

  const CoreContainer.large({
    Key? key,
    this.child,
    this.margin,
    this.padding = const CoreSpacing(all: CoreSpacingType.large),
    this.visible = true,
    this.bordered = false,
    this.color,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.radius = false,
    this.borderColor = CoreColorType.neutral300,
  }) : super(key: key);

  const CoreContainer.huge({
    Key? key,
    this.child,
    this.margin,
    this.padding = const CoreSpacing(all: CoreSpacingType.huge),
    this.visible = true,
    this.bordered = false,
    this.color,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.radius = false,
    this.borderColor = CoreColorType.neutral300,
  }) : super(key: key);

  final AlignmentGeometry? alignment;
  final BoxDecoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior = Clip.none;
  //custom props
  final CoreColorType? color;
  final CoreSpacing? padding;
  final CoreSpacing? margin;
  final bool visible;
  final bool bordered;
  final bool radius;
  final CoreColorType borderColor;

  final Widget? child;

  EdgeInsetsGeometry? getPadding(BuildContext context) {
    if (padding != null) {
      double _left = Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[padding!.left] ??
          0.0;
      double _top = Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[padding!.top] ??
          0.0;
      double _right = Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[padding!.right] ??
          0.0;
      double _bottom = Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[padding!.bottom] ??
          0.0;
      return EdgeInsets.fromLTRB(_left, _top, _right, _bottom);
    }
    return null;
  }

  EdgeInsetsGeometry? getMargin(BuildContext context) {
    if (margin != null) {
      double _left = Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[margin!.left] ??
          0.0;
      double _top = Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[margin!.top] ??
          0.0;
      double _right = Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[margin!.right] ??
          0.0;
      double _bottom = Theme.of(context)
              .extension<CoreSpacingTheme>()!
              .values[margin!.bottom] ??
          0.0;
      return EdgeInsets.fromLTRB(_left, _top, _right, _bottom);
    }
    return null;
  }

  Decoration getCurrentDecoration(BuildContext context) {
    BoxDecoration _decoration = this.decoration ?? BoxDecoration();
    if (this.bordered) {
      _decoration = _decoration.copyWith(
        border: Border.all(
          width: 1,
          color: Theme.of(context)
                  .extension<CoreColorTheme>()!
                  .values[borderColor] ??
              const Color(0xFFD6D6D6),
        ),
        borderRadius: BorderRadius.circular(
          Theme.of(context)
                  .extension<CoreBorderRadiusTheme>()!
                  .values[CoreBorderRadiusType.medium] ??
              5,
        ),
      );
    } else if (this.radius) {
      _decoration = _decoration.copyWith(
        borderRadius: BorderRadius.circular(
          Theme.of(context)
                  .extension<CoreBorderRadiusTheme>()!
                  .values[CoreBorderRadiusType.medium] ??
              5,
        ),
      );
    }
    _decoration = _decoration.copyWith(
      color: this.color != null
          ? Theme.of(context).extension<CoreColorTheme>()!.values[color]
          : Colors.transparent,
    );
    return _decoration;
  }

  @override
  Widget build(BuildContext context) {
    return this.visible
        ? Container(
            child: this.child,
            padding: getPadding(context),
            margin: getMargin(context),
            alignment: alignment,
            decoration: this.getCurrentDecoration(context),
            foregroundDecoration: foregroundDecoration,
            width: width,
            height: height,
            constraints: constraints,
            transform: transform,
            transformAlignment: transformAlignment,
            clipBehavior: clipBehavior,
          )
        : SizedBox.shrink();
  }
}
