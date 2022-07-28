import 'package:foundation/interfaces/theme/custom_theme.dart';

import '../theme/constants.dart';
import 'package:fairplay_ds/theme/interfaces/button_theme.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/icon_theme.dart';
import 'package:fairplay_ds/theme/interfaces/message_theme.dart';
import 'package:fairplay_ds/theme/interfaces/pin_code_theme.dart';
import 'package:fairplay_ds/theme/interfaces/progress_indicator_theme.dart';
import 'package:fairplay_ds/theme/interfaces/radius_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:fairplay_ds/theme/interfaces/step_theme.dart';
import 'package:fairplay_ds/theme/interfaces/stepper_theme.dart';
import 'package:fairplay_ds/theme/interfaces/text_input_theme.dart';
import 'package:fairplay_ds/theme/interfaces/typography_theme.dart';
import 'package:flutter/material.dart';

class CustomTheme implements CustomThemeInterface {
  CustomTheme() {
    const String _fontFamily = 'Roboto';

    final AppBarTheme _appBarTheme = AppBarTheme(
      iconTheme: IconThemeData(color: CoreColorScheme().primary),
      color: CoreColorScheme().neutralWhite,
      elevation: 1.0,
    );

    final BottomNavigationBarThemeData _bottomNavigationBar =
        BottomNavigationBarThemeData(
      elevation: 8.0,
      selectedItemColor: CoreColorScheme().primary,
      unselectedItemColor: CoreColorScheme().neutral400,
    );

    final CoreButtonTheme _coreButtonTheme = CoreButtonTheme(
      size: <CoreButtonSizeType, CoreButtonThemeData>{
        CoreButtonSizeType.tiny: CoreButtonThemeData(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: CoreFontSize().caption,
          ),
        ),
        CoreButtonSizeType.small: CoreButtonThemeData(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: CoreFontSize().bodyText1,
          ),
        ),
        CoreButtonSizeType.medium: CoreButtonThemeData(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: CoreFontSize().bodyText1,
          ),
        ),
      },
      elevatedState: <CoreButtonStateType, CoreButtonThemeData>{
        CoreButtonStateType.normal: CoreButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreRadius().medium),
          ),
          fillColor: CoreColorScheme().primary,
          textColor: CoreColorScheme().neutralWhite,
          splashColor: CoreColorScheme().primaryLight,
        ),
        CoreButtonStateType.disabled: CoreButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreRadius().medium),
            side: BorderSide(
              width: 1.5,
              color: CoreColorScheme().neutral400,
            ),
          ),
          fillColor: CoreColorScheme().neutral200,
          textColor: CoreColorScheme().neutral400,
        ),
        CoreButtonStateType.loader: CoreButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreRadius().medium),
            side: BorderSide(
              width: 1.5,
              color: CoreColorScheme().neutral400,
            ),
          ),
          fillColor: CoreColorScheme().neutral200,
          highlightColor: CoreColorScheme().neutralWhite,
          textColor: CoreColorScheme().neutral400,
        ),
      },
      outlinedState: <CoreButtonStateType, CoreButtonThemeData>{
        CoreButtonStateType.normal: CoreButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreRadius().medium),
            side: BorderSide(
              width: 1.5,
              color: CoreColorScheme().neutral300,
            ),
          ),
          fillColor: CoreColorScheme().neutralWhite,
          textColor: CoreColorScheme().neutral600,
          splashColor: CoreColorScheme().neutral200,
        ),
        CoreButtonStateType.disabled: CoreButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreRadius().medium),
            side: BorderSide(
              width: 1.5,
              color: CoreColorScheme().neutral300,
            ),
          ),
          fillColor: CoreColorScheme().neutralWhite,
          highlightColor: CoreColorScheme().neutralWhite,
          textColor: CoreColorScheme().neutral400,
        ),
        CoreButtonStateType.loader: CoreButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreRadius().medium),
            side: BorderSide(
              width: 1.5,
              color: CoreColorScheme().neutral300,
            ),
          ),
          fillColor: CoreColorScheme().neutralWhite,
          highlightColor: CoreColorScheme().neutralWhite,
          textColor: CoreColorScheme().neutral400,
        ),
      },
      ghostedState: <CoreButtonStateType, CoreButtonThemeData>{
        CoreButtonStateType.normal: CoreButtonThemeData(
          fillColor: CoreColorScheme().neutralWhite,
          highlightColor: CoreColorScheme().neutralWhite,
          textColor: CoreColorScheme().neutral600,
          splashColor: CoreColorScheme().neutral200,
        ),
        CoreButtonStateType.disabled: CoreButtonThemeData(
          fillColor: CoreColorScheme().neutralWhite,
          highlightColor: CoreColorScheme().neutralWhite,
          textColor: CoreColorScheme().neutral400,
        ),
        CoreButtonStateType.loader: CoreButtonThemeData(
          fillColor: CoreColorScheme().neutralWhite,
          highlightColor: CoreColorScheme().neutralWhite,
          textColor: CoreColorScheme().neutral400,
        ),
      },
    );

    final SnackBarThemeData _snackBarTheme = SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: CoreColorScheme().neutral600,
      actionTextColor: CoreColorScheme().neutralWhite,
      contentTextStyle: TextStyle(
        color: CoreColorScheme().neutralWhite,
        fontSize: CoreFontSize().caption,
      ),
    );

    final CoreTypographyTheme _textTheme = CoreTypographyTheme(
      values: <CoreTextType, TextStyle>{
        CoreTextType.headline1: TextStyle(
          fontSize: CoreFontSize().headline1,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.headline2: TextStyle(
          fontSize: CoreFontSize().headline2,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.headline3: TextStyle(
          fontSize: CoreFontSize().headline3,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.headline4: TextStyle(
          fontSize: CoreFontSize().headline4,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.headline5: TextStyle(
          fontSize: CoreFontSize().headline5,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.headline6: TextStyle(
          fontSize: CoreFontSize().headline6,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.bodyText1: TextStyle(
          fontSize: CoreFontSize().bodyText1,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.bodyText1Normal: TextStyle(
          fontSize: CoreFontSize().bodyText1,
          fontWeight: FontWeight.normal,
        ),
        CoreTextType.bodyText2: TextStyle(
          fontSize: CoreFontSize().bodyText2,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.bodyText2Normal: TextStyle(
          fontSize: CoreFontSize().bodyText2,
          fontWeight: FontWeight.normal,
        ),
        CoreTextType.label: TextStyle(
          fontSize: CoreFontSize().caption,
          fontWeight: FontWeight.bold,
        ),
        CoreTextType.caption: TextStyle(
          fontSize: CoreFontSize().caption,
          fontWeight: FontWeight.normal,
        ),
      },
    );

    final TabBarTheme _tabBarTheme = TabBarTheme(
      labelColor: CoreColorScheme().primary,
      unselectedLabelColor: CoreColorScheme().neutral400,
    );

    final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
      errorStyle: const TextStyle(
        height: 0.0,
        fontSize: 0.0,
      ),
      filled: true,
      isDense: true,
      fillColor: CoreColorScheme().neutralWhite,
      // fillColorDisabled: CoreColorScheme().neutralWhite,
    );

    final CoreInputDecorationTheme _coreInputTheme = CoreInputDecorationTheme(
      CoreInputDecorationMapper(
        state: <TextInputStateType, CoreInputDecorationThemeData>{
          TextInputStateType.disabled: CoreInputDecorationThemeData(
            placeholderStyle: TextStyle(
              color: CoreColorScheme().neutral300,
              fontSize: CoreFontSize().bodyText2,
            ),
            labelStyle: TextStyle(
              color: CoreColorScheme().neutral300,
              fontWeight: FontWeight.bold,
              fontSize: CoreFontSize().caption,
            ),
            fieldStyle: TextStyle(
              color: CoreColorScheme().neutralBlack,
              fontSize: CoreFontSize().bodyText2,
            ),
          ),
          TextInputStateType.enable: CoreInputDecorationThemeData(
            placeholderStyle: TextStyle(
              color: CoreColorScheme().neutral400,
              fontSize: CoreFontSize().bodyText2,
            ),
            labelStyle: TextStyle(
              color: CoreColorScheme().neutral500,
              fontWeight: FontWeight.bold,
              fontSize: CoreFontSize().caption,
            ),
            fieldStyle: TextStyle(
              color: CoreColorScheme().neutralBlack,
              fontSize: CoreFontSize().bodyText2,
            ),
          ),
          TextInputStateType.focusOrFill: CoreInputDecorationThemeData(
            placeholderStyle: TextStyle(
              color: CoreColorScheme().neutral400,
              fontSize: CoreFontSize().bodyText2,
            ),
            labelStyle: TextStyle(
              color: CoreColorScheme().neutral500,
              fontWeight: FontWeight.bold,
              fontSize: CoreFontSize().caption,
            ),
            animatedLabelStyle: TextStyle(
              color: CoreColorScheme().neutral500,
              fontWeight: FontWeight.bold,
              fontSize: CoreFontSize().bodyText1,
            ),
            fieldStyle: TextStyle(
              color: CoreColorScheme().neutralBlack,
              fontSize: CoreFontSize().bodyText2,
            ),
          ),
          TextInputStateType.error: CoreInputDecorationThemeData(
            placeholderStyle: TextStyle(
              color: CoreColorScheme().neutral400,
              fontSize: CoreFontSize().bodyText2,
            ),
            labelStyle: TextStyle(
              color: CoreColorScheme().neutral500,
              fontWeight: FontWeight.bold,
              fontSize: CoreFontSize().caption,
            ),
            fieldStyle: TextStyle(
              color: CoreColorScheme().neutralBlack,
              fontSize: CoreFontSize().bodyText2,
            ),
            messageType: CoreMessageType.error,
          ),
          TextInputStateType.success: CoreInputDecorationThemeData(
            placeholderStyle: TextStyle(
              color: CoreColorScheme().neutral400,
              fontSize: CoreFontSize().bodyText2,
            ),
            labelStyle: TextStyle(
              color: CoreColorScheme().neutral500,
              fontWeight: FontWeight.bold,
              fontSize: CoreFontSize().caption,
            ),
            fieldStyle: TextStyle(
              color: CoreColorScheme().neutralBlack,
              fontSize: CoreFontSize().bodyText2,
            ),
            messageType: CoreMessageType.success,
          ),
        },
        decoration: <TextInputDecorationType, InputDecoration>{
          TextInputDecorationType.underline: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().neutral300,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().primary,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().primary,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().error,
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().neutral300,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(maxHeight: 12),
            contentPadding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
          ),
          TextInputDecorationType.outline: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().neutral300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().primary,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().primary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().error,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CoreColorScheme().neutral300,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(maxHeight: 18),
            prefixIconConstraints: const BoxConstraints(maxHeight: 20),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
        },
      ),
    );

    final CoreColorTheme _colorTheme = CoreColorTheme(
      values: <CoreColorType, Color>{
        CoreColorType.primary: CoreColorScheme().primary,
        CoreColorType.secondary: CoreColorScheme().secondary,
        CoreColorType.alert: CoreColorScheme().alert,
        CoreColorType.alertDark: CoreColorScheme().alertDark,
        CoreColorType.alertLightest: CoreColorScheme().alertLightest,
        CoreColorType.informative: CoreColorScheme().informative,
        CoreColorType.informativeLightest:
            CoreColorScheme().informativeLightest,
        CoreColorType.informativeDark: CoreColorScheme().informativeDark,
        CoreColorType.success: CoreColorScheme().success,
        CoreColorType.successLightest: CoreColorScheme().successLightest,
        CoreColorType.successDark: CoreColorScheme().successDark,
        CoreColorType.error: CoreColorScheme().error,
        CoreColorType.errorDark: CoreColorScheme().errorDark,
        CoreColorType.errorLightest: CoreColorScheme().errorLightest,
        CoreColorType.neutralWhite: CoreColorScheme().neutralWhite,
        CoreColorType.neutral200: CoreColorScheme().neutral200,
        CoreColorType.neutral300: CoreColorScheme().neutral300,
        CoreColorType.neutral400: CoreColorScheme().neutral400,
        CoreColorType.neutral500: CoreColorScheme().neutral500,
        CoreColorType.neutral600: CoreColorScheme().neutral600,
        CoreColorType.neutralBlack: CoreColorScheme().neutralBlack,
        CoreColorType.overlay: CoreColorScheme().overlay,
      },
    );

    final ColorScheme _colorScheme = ColorScheme(
      primary: CoreColorScheme().primary,
      secondary: CoreColorScheme().secondary,
      surface: CoreColorScheme().neutralWhite,
      background: CoreColorScheme().neutralWhite,
      error: CoreColorScheme().error,
      onPrimary: CoreColorScheme().neutralWhite,
      onSecondary: CoreColorScheme().neutralWhite,
      onSurface: CoreColorScheme().neutralBlack,
      onBackground: CoreColorScheme().neutralBlack,
      onError: CoreColorScheme().neutralWhite,
      brightness: Brightness.light,
    );

    final CoreSpacingTheme _spacingTheme = CoreSpacingTheme(
      values: <CoreSpacingType, double>{
        CoreSpacingType.none: CoreSpacingSize().none,
        CoreSpacingType.tiny: CoreSpacingSize().tiny,
        CoreSpacingType.small: CoreSpacingSize().small,
        CoreSpacingType.medium: CoreSpacingSize().medium,
        CoreSpacingType.large: CoreSpacingSize().large,
        CoreSpacingType.huge: CoreSpacingSize().huge,
      },
    );

    final CoreIconSizeTheme _iconTheme = CoreIconSizeTheme(
      values: <CoreIconSizeType, double>{
        CoreIconSizeType.none: CoreIconSize().none,
        CoreIconSizeType.tiny: CoreIconSize().tiny,
        CoreIconSizeType.small: CoreIconSize().small,
        CoreIconSizeType.medium: CoreIconSize().medium,
        CoreIconSizeType.large: CoreIconSize().large,
        CoreIconSizeType.huge: CoreIconSize().huge,
      },
    );

    final CoreBorderRadiusTheme _borderRadiusTheme = CoreBorderRadiusTheme(
      values: <CoreBorderRadiusType, double>{
        CoreBorderRadiusType.small: CoreRadius().small,
        CoreBorderRadiusType.medium: CoreRadius().medium,
        CoreBorderRadiusType.large: CoreRadius().large,
        CoreBorderRadiusType.circular: CoreRadius().circular,
      },
    );

    final CoreMessageTheme _messageTheme = CoreMessageTheme(
      values: <CoreMessageType, CoreMessageThemeData>{
        CoreMessageType.success: CoreMessageThemeData(
          path: 'assets/images/icons/success_circle.svg',
          colorType: CoreColorType.success,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: CoreFontSize().caption,
            color: CoreColorScheme().success,
          ),
        ),
        CoreMessageType.error: CoreMessageThemeData(
          path: 'assets/images/icons/warning_circle.svg',
          colorType: CoreColorType.error,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: CoreFontSize().caption,
            color: CoreColorScheme().error,
          ),
        ),
      },
    );

    final CoreStepTheme _stepTheme = CoreStepTheme(
      values: {
        CoreStepType.active: CoreStepThemeData(
          path: Icons.check,
          color: CoreColorType.success,
          colorLine: CoreColorType.success,
          titleStyle: TextStyle(
            fontSize: CoreFontSize().bodyText2,
            color: CoreColorScheme().neutralBlack,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: TextStyle(
            fontSize: CoreFontSize().caption,
            color: CoreColorScheme().neutral400,
          ),
        ),
        CoreStepType.error: CoreStepThemeData(
          path: Icons.priority_high_rounded,
          color: CoreColorType.error,
          colorLine: CoreColorType.error,
          titleStyle: TextStyle(
            fontSize: CoreFontSize().bodyText2,
            color: CoreColorScheme().neutralBlack,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: TextStyle(
            fontSize: CoreFontSize().caption,
            color: CoreColorScheme().neutral400,
          ),
        ),
        CoreStepType.disabled: CoreStepThemeData(
          path: Icons.check,
          color: CoreColorType.neutral300,
          colorLine: CoreColorType.neutral300,
          titleStyle: TextStyle(
            fontSize: CoreFontSize().bodyText2,
            color: CoreColorScheme().neutralBlack,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: TextStyle(
            fontSize: CoreFontSize().caption,
            color: CoreColorScheme().neutral400,
          ),
        ),
      },
    );

    final TextSelectionThemeData textSelection = TextSelectionThemeData(
      cursorColor: CoreColorScheme().primary,
    );

    final CoreProgressIndicatorTheme _progressIndicatorTheme =
        CoreProgressIndicatorTheme(
      values: <CoreProgressIndicatorType, CoreProgressIndicatorThemeData>{
        CoreProgressIndicatorType.small: CoreProgressIndicatorThemeData(
          size: 17.0,
          strokeWidth: 1.5,
          colorType: CoreColorType.primary,
          backgroundColor: CoreColorScheme().neutral300,
        ),
        CoreProgressIndicatorType.medium: CoreProgressIndicatorThemeData(
          size: 25.0,
          strokeWidth: 2.0,
          colorType: CoreColorType.primary,
          backgroundColor: CoreColorScheme().neutral300,
        ),
        CoreProgressIndicatorType.large: CoreProgressIndicatorThemeData(
          size: 40.0,
          strokeWidth: 2.0,
          colorType: CoreColorType.primary,
          backgroundColor: CoreColorScheme().neutral300,
        ),
      },
    );

    final CoreStepperTheme _stepperTheme = CoreStepperTheme(
      values: CoreStepperThemeData(
        colorLineCompletedProgress: CoreColorType.primary,
        colorLineRemainingProgress: CoreColorType.neutral200,
        progressStyle: TextStyle(
          fontSize: CoreFontSize().caption,
          color: CoreColorScheme().neutral400,
          fontWeight: FontWeight.w400,
        ),
        titleStyle: TextStyle(
          fontSize: CoreFontSize().headline5,
          color: CoreColorScheme().neutralBlack,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    final CorePinCodeTheme _corePinCodeTheme = CorePinCodeTheme(
      value: CorePinCodeThemeData(
        valueStyle: const TextStyle(fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: CoreColorScheme().primary,
          ),
        ),
      ),
    );

    values = ThemeData(
      dividerColor: Colors.transparent,
      snackBarTheme: _snackBarTheme,
      appBarTheme: _appBarTheme,
      bottomNavigationBarTheme: _bottomNavigationBar,
      canvasColor: Colors.transparent,
      fontFamily: _fontFamily,
      inputDecorationTheme: _inputDecorationTheme,
      scaffoldBackgroundColor: CoreColorScheme().neutralWhite,
      tabBarTheme: _tabBarTheme,
      colorScheme: _colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: textSelection,
      extensions: <ThemeExtension<dynamic>>{
        _textTheme,
        _coreButtonTheme,
        _coreInputTheme,
        _spacingTheme,
        _iconTheme,
        _borderRadiusTheme,
        _messageTheme,
        _stepTheme,
        _progressIndicatorTheme,
        _colorTheme,
        _stepperTheme,
        _corePinCodeTheme,
      },
    );
  }

  @override
  late ThemeData values;
}
