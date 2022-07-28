import 'package:fairplay_ds/theme/interfaces/mapper_theme.dart';
import 'package:flutter/material.dart';

enum CoreButtonSizeType { tiny, small, medium }

enum CoreButtonStateType { disabled, normal, loader }

enum CoreButtonType { outlined, ghosted, elevated }

class CoreButtonMapper {
  CoreButtonMapper({
    required Map<CoreButtonSizeType, CoreButtonThemeData> size,
    required Map<CoreButtonStateType, CoreButtonThemeData> state,
  }) : values =
            <CoreButtonSizeType, Map<CoreButtonStateType, CoreButtonThemeData>>{
          CoreButtonSizeType.tiny: <CoreButtonStateType, CoreButtonThemeData>{
            CoreButtonStateType.disabled: size[CoreButtonSizeType.tiny]!
                .merge(state[CoreButtonStateType.disabled]),
            CoreButtonStateType.normal: size[CoreButtonSizeType.tiny]!
                .merge(state[CoreButtonStateType.normal]),
            CoreButtonStateType.loader: size[CoreButtonSizeType.tiny]!
                .merge(state[CoreButtonStateType.loader]),
          },
          CoreButtonSizeType.small: <CoreButtonStateType, CoreButtonThemeData>{
            CoreButtonStateType.disabled: size[CoreButtonSizeType.small]!
                .merge(state[CoreButtonStateType.disabled]),
            CoreButtonStateType.normal: size[CoreButtonSizeType.small]!
                .merge(state[CoreButtonStateType.normal]),
            CoreButtonStateType.loader: size[CoreButtonSizeType.small]!
                .merge(state[CoreButtonStateType.loader]),
          },
          CoreButtonSizeType.medium: <CoreButtonStateType, CoreButtonThemeData>{
            CoreButtonStateType.disabled: size[CoreButtonSizeType.medium]!
                .merge(state[CoreButtonStateType.disabled]),
            CoreButtonStateType.normal: size[CoreButtonSizeType.medium]!
                .merge(state[CoreButtonStateType.normal]),
            CoreButtonStateType.loader: size[CoreButtonSizeType.medium]!
                .merge(state[CoreButtonStateType.loader]),
          }
        };

  final Map<CoreButtonSizeType, Map<CoreButtonStateType, CoreButtonThemeData>>
      values;
}

class CoreButtonThemeData {
  CoreButtonThemeData({
    this.textColor,
    this.textStyle,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.padding,
    this.constraints,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.shape,
  });

  CoreButtonThemeData merge(CoreButtonThemeData? style) {
    if (style == null) return this;
    return CoreButtonThemeData(
      textStyle: textStyle ?? style.textStyle,
      fillColor: fillColor ?? style.fillColor,
      focusColor: focusColor ?? style.focusColor,
      hoverColor: hoverColor ?? style.hoverColor,
      highlightColor: highlightColor ?? style.highlightColor,
      splashColor: splashColor ?? style.splashColor,
      elevation: elevation ?? style.elevation,
      focusElevation: focusElevation ?? style.focusElevation,
      hoverElevation: hoverElevation ?? style.hoverElevation,
      highlightElevation: highlightElevation ?? style.highlightElevation,
      disabledElevation: disabledElevation ?? style.disabledElevation,
      padding: padding ?? style.padding,
      constraints: constraints ?? style.constraints,
      shape: shape ?? style.shape,
      textColor: textColor ?? style.textColor,
    );
  }

  final TextStyle? textStyle;
  final Color? textColor;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final ShapeBorder? shape;
}

class CoreButtonTheme extends ThemeExtension<CoreButtonTheme>
    with MapperThemeBehavior<CoreButtonTheme> {
  CoreButtonTheme({
    required Map<CoreButtonSizeType, CoreButtonThemeData> size,
    required Map<CoreButtonStateType, CoreButtonThemeData> elevatedState,
    required Map<CoreButtonStateType, CoreButtonThemeData> outlinedState,
    required Map<CoreButtonStateType, CoreButtonThemeData> ghostedState,
  }) : values = {
          CoreButtonType.outlined:
              CoreButtonMapper(size: size, state: outlinedState).values,
          CoreButtonType.elevated:
              CoreButtonMapper(size: size, state: elevatedState).values,
          CoreButtonType.ghosted:
              CoreButtonMapper(size: size, state: ghostedState).values,
        };

  final Map<
      CoreButtonType,
      Map<CoreButtonSizeType,
          Map<CoreButtonStateType, CoreButtonThemeData>>> values;
}
