import 'package:fairplay_ds/theme/interfaces/message_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';
import './core_container.dart';
import './core_typography.dart';
import './core_icon.dart';

class CoreMessage extends StatelessWidget {
  const CoreMessage({
    Key? key,
    String? message,
    required this.type,
  })  : this.message = message ?? '',
        super(key: key);

  const CoreMessage.error({
    Key? key,
    String? message,
  })  : this.type = CoreMessageType.error,
        this.message = message ?? '',
        super(key: key);

  const CoreMessage.success({
    Key? key,
    String? message,
  })  : this.type = CoreMessageType.success,
        this.message = message ?? '',
        super(key: key);

  final CoreMessageType type;
  final String message;

  CoreMessageThemeData _getThemedStyle(BuildContext context) {
    return Theme.of(context).extension<CoreMessageTheme>()!.values[type] ??
        CoreMessageThemeData.defaultInstance();
  }

  @override
  Widget build(BuildContext context) {
    CoreMessageThemeData currentStyle = _getThemedStyle(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CoreIcon(
          icon: currentStyle.path,
          color: currentStyle.colorType,
        ),
        const CoreContainer(
          padding: CoreSpacing(
            left: CoreSpacingType.tiny,
          ),
        ),
        CoreTypography.caption(
          message,
          textStyle: currentStyle.textStyle,
          color: currentStyle.colorType,
        ),
      ],
    );
  }
}
