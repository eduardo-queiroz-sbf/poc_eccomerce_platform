import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoreSnackBar extends StatelessWidget {
  CoreSnackBar({
    required this.value,
    this.actionText,
    this.action,
    this.backgroundColor,
  });

  CoreSnackBar.undo({
    required BuildContext context,
    required this.value,
    this.actionText = 'Desfazer',
    required this.action,
  }) : backgroundColor = null {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(_snackBar(context));
  }

  CoreSnackBar.success({
    required BuildContext context,
    required this.value,
    this.backgroundColor = CoreColorType.success,
  })  : actionText = null,
        action = null {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(_snackBar(context));
  }

  CoreSnackBar.show({
    required BuildContext context,
    required this.value,
  })  : actionText = null,
        action = null,
        backgroundColor = null {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(_snackBar(context));
  }

  CoreSnackBar.copy({
    required BuildContext context,
    this.value = 'Item copiado com sucesso!',
    required String copyValue,
  })  : actionText = null,
        action = null,
        backgroundColor = null {
    Clipboard.setData(ClipboardData(text: copyValue));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(_snackBar(context));
  }

  final String value;
  final String? actionText;
  final VoidCallback? action;
  final CoreColorType? backgroundColor;

  SnackBar _snackBar(context) {
    return SnackBar(
      backgroundColor: Theme.of(context)
          .extension<CoreColorTheme>()!
          .values[backgroundColor],
      content: CoreContainer(
        padding: const CoreSpacing(
          vertical: CoreSpacingType.small,
        ),
        child: CoreTypography.caption(
          value,
          color: CoreColorType.neutralWhite,
        ),
      ),
      action: actionText != null
          ? SnackBarAction(
              label: actionText!,
              onPressed: action!,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _snackBar(context);
  }
}
