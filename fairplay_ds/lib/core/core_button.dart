import 'package:fairplay_ds/core/core_request_builder.dart';
import 'package:fairplay_ds/theme/interfaces/button_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'core_container.dart';
import 'core_progress_indicator.dart';

class CoreButton extends StatefulWidget {
  const CoreButton({
    required this.content,
    required this.coreButtonType,
    required this.coreButtonSizeType,
    this.disabled = false,
    this.onPress,
    this.onLongPress,
    this.onError,
    this.key,
    this.countdownSeconds,
  });

  const CoreButton.elevated({
    required this.content,
    this.coreButtonSizeType = CoreButtonSizeType.medium,
    this.disabled = false,
    this.onPress,
    this.onLongPress,
    this.onError,
    this.key,
    this.countdownSeconds,
  }) : this.coreButtonType = CoreButtonType.elevated;

  const CoreButton.outlined({
    required this.content,
    this.coreButtonSizeType = CoreButtonSizeType.medium,
    this.disabled = false,
    this.onPress,
    this.onLongPress,
    this.onError,
    this.key,
    this.countdownSeconds,
  }) : this.coreButtonType = CoreButtonType.outlined;

  const CoreButton.ghosted({
    required this.content,
    this.coreButtonSizeType = CoreButtonSizeType.medium,
    this.disabled = false,
    this.onPress,
    this.onLongPress,
    this.onError,
    this.key,
    this.countdownSeconds,
  }) : this.coreButtonType = CoreButtonType.ghosted;

  final String content;
  final CoreButtonType coreButtonType;
  final CoreButtonSizeType coreButtonSizeType;
  final bool disabled;
  final AsyncCallback? onPress;
  final AsyncCallback? onLongPress;
  final RequestError? onError;
  final Key? key;
  final int? countdownSeconds;

  @override
  State<StatefulWidget> createState() => _CoreButtonState();
}

class _CoreButtonState extends State<CoreButton> {
  CoreButtonStateType currentState = CoreButtonStateType.normal;
  int? timerCount;

  AsyncCallback? _onPressed(dynamic onPress, RequestError? onError) {
    if (currentState != CoreButtonStateType.normal || onPress == null) {
      // make the button disabled
      return null;
    } else {
      if (currentState == CoreButtonStateType.normal && timerCount == null) {
        return () async {
          try {
            initCountDownTimer();
            await onPress();
          } catch (e) {
            setState(() {
              currentState = CoreButtonStateType.normal;
            });
            onError?.call(error: e);
          }
        };
      }
      return () async {
        try {
          setState(() {
            currentState = CoreButtonStateType.loader;
          });

          await onPress();

          setState(() {
            currentState = CoreButtonStateType.normal;
          });
        } catch (e) {
          setState(() {
            currentState = CoreButtonStateType.normal;
          });
          onError?.call(error: e);
        }
      };
    }
  }

  void initState() {
    if (widget.disabled) {
      disableCurrentState();
    }
    super.initState();
  }

  Future<void> initCountDownTimer() async {
    timerCount = widget.countdownSeconds ?? 0;
    disableCurrentState();
    await countDownTimer();
    enableCurrentState();
    timerCount = null;
  }

  void disableCurrentState() {
    setState(() {
      currentState = CoreButtonStateType.disabled;
    });
  }

  void enableCurrentState() {
    setState(() {
      currentState = CoreButtonStateType.normal;
    });
  }

  Future<void> countDownTimer() async {
    if (timerCount == null) {
      return;
    }
    for (int i = widget.countdownSeconds ?? 0; i > 0; i--) {
      await Future.delayed(
        Duration(seconds: 1),
      ).then((_) {
        setState(() {
          timerCount = timerCount! - 1;
        });
      });
    }
  }

  void didUpdateWidget(oldWidget) {
    if (widget.disabled) {
      setState(() {
        currentState = CoreButtonStateType.disabled;
      });
    } else if (oldWidget.disabled && !widget.disabled) {
      setState(() {
        currentState = CoreButtonStateType.normal;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  CoreButtonThemeData _getThemedStyle(BuildContext context) {
    return Theme.of(context)
                .extension<CoreButtonTheme>()!
                .values[widget.coreButtonType]?[widget.coreButtonSizeType]
            ?[currentState] ??
        CoreButtonThemeData();
  }

  @override
  Widget build(BuildContext context) {
    final CoreButtonThemeData currentStyle = _getThemedStyle(context);
    final String textContent = widget.content +
        (timerCount != null && currentState == CoreButtonStateType.disabled
            ? " em ${timerCount}s"
            : "");
    return RawMaterialButton(
      shape: currentStyle.shape ?? const RoundedRectangleBorder(),
      textStyle: currentStyle.textStyle,
      fillColor: currentStyle.fillColor,
      focusColor: currentStyle.focusColor,
      hoverColor: currentStyle.hoverColor,
      highlightColor: currentStyle.highlightColor,
      splashColor: currentStyle.splashColor,
      padding: currentStyle.padding ?? EdgeInsets.zero,
      constraints: currentStyle.constraints ??
          const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      elevation: currentStyle.elevation ?? 0.0,
      focusElevation: currentStyle.focusElevation ?? 0.0,
      hoverElevation: currentStyle.hoverElevation ?? 0.0,
      highlightElevation: currentStyle.highlightElevation ?? 0.0,
      disabledElevation: currentStyle.disabledElevation ?? 0.0,
      onPressed: _onPressed(widget.onPress, widget.onError),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            textContent,
            style:
                currentStyle.textStyle?.copyWith(color: currentStyle.textColor),
          ),
          CoreContainer(
            visible: currentState == CoreButtonStateType.loader,
            margin: CoreSpacing(left: CoreSpacingType.medium),
            child: CoreProgressIndicator.small(),
          ),
        ],
      ),
    );
  }
}
