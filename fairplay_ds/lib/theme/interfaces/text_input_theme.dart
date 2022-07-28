import 'package:fairplay_ds/theme/interfaces/message_theme.dart';
import 'package:flutter/material.dart';

import 'mapper_theme.dart';

enum TextInputDecorationType {
  outline,
  underline,
}

enum TextInputStateType { disabled, enable, error, success, focusOrFill }

class CoreInputDecorationThemeData {
  CoreInputDecorationThemeData({
    required this.labelStyle,
    required this.placeholderStyle,
    this.animatedLabelStyle = const TextStyle(),
    this.fieldStyle = const TextStyle(),
    this.messageType,
    this.inputDecoration,
  });

  CoreInputDecorationThemeData.defaultInstance({
    this.labelStyle = const TextStyle(),
    this.placeholderStyle = const TextStyle(),
    this.animatedLabelStyle = const TextStyle(),
    this.fieldStyle = const TextStyle(),
    this.messageType,
    this.inputDecoration,
  });

  final TextStyle labelStyle;
  final TextStyle animatedLabelStyle;
  final TextStyle placeholderStyle;
  final TextStyle fieldStyle;
  final InputDecoration? inputDecoration;
  final CoreMessageType? messageType;

  CoreInputDecorationThemeData copyWith({
    TextStyle? labelStyle,
    TextStyle? animatedLabelStyle,
    TextStyle? placeholderStyle,
    CoreMessageType? messageType,
    InputDecoration? inputDecoration,
  }) {
    return CoreInputDecorationThemeData(
      labelStyle: labelStyle ?? this.labelStyle,
      animatedLabelStyle: animatedLabelStyle ?? this.animatedLabelStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      inputDecoration:
          inputDecoration ?? this.inputDecoration ?? InputDecoration(),
      messageType: messageType ?? this.messageType,
    );
  }
}

class CoreInputDecorationMapper {
  CoreInputDecorationMapper({
    required Map<TextInputDecorationType, InputDecoration> decoration,
    required Map<TextInputStateType, CoreInputDecorationThemeData> state,
  }) : values = <TextInputDecorationType,
            Map<TextInputStateType, CoreInputDecorationThemeData>>{
          TextInputDecorationType.outline:
              <TextInputStateType, CoreInputDecorationThemeData>{
            TextInputStateType.disabled: state[TextInputStateType.disabled]!
                .copyWith(
                    inputDecoration:
                        decoration[TextInputDecorationType.outline]!),
            TextInputStateType.enable: state[TextInputStateType.enable]!
                .copyWith(
                    inputDecoration:
                        decoration[TextInputDecorationType.outline]!),
            TextInputStateType.focusOrFill:
                state[TextInputStateType.focusOrFill]!.copyWith(
                    inputDecoration:
                        decoration[TextInputDecorationType.outline]!),
            TextInputStateType.error: state[TextInputStateType.error]!.copyWith(
                inputDecoration: decoration[TextInputDecorationType.outline]!),
            TextInputStateType.success: state[TextInputStateType.success]!
                .copyWith(
                    inputDecoration:
                        decoration[TextInputDecorationType.outline]!),
          },
          TextInputDecorationType.underline:
              <TextInputStateType, CoreInputDecorationThemeData>{
            TextInputStateType.disabled: state[TextInputStateType.disabled]!
                .copyWith(
                    inputDecoration:
                        decoration[TextInputDecorationType.underline]!),
            TextInputStateType.enable: state[TextInputStateType.enable]!
                .copyWith(
                    inputDecoration:
                        decoration[TextInputDecorationType.underline]!),
            TextInputStateType.focusOrFill:
                state[TextInputStateType.focusOrFill]!.copyWith(
                    inputDecoration:
                        decoration[TextInputDecorationType.underline]!),
            TextInputStateType.error: state[TextInputStateType.error]!.copyWith(
                inputDecoration:
                    decoration[TextInputDecorationType.underline]!),
            TextInputStateType.success: state[TextInputStateType.success]!
                .copyWith(
                    inputDecoration:
                        decoration[TextInputDecorationType.underline]!),
          },
        };

  final Map<TextInputDecorationType,
      Map<TextInputStateType, CoreInputDecorationThemeData>> values;
}

class CoreInputDecorationTheme extends ThemeExtension<CoreInputDecorationTheme>
    with MapperThemeBehavior<CoreInputDecorationTheme> {
  CoreInputDecorationTheme(CoreInputDecorationMapper inputDecorationMapper)
      : this.values = inputDecorationMapper.values;

  final Map<TextInputDecorationType,
      Map<TextInputStateType, CoreInputDecorationThemeData>> values;
}
