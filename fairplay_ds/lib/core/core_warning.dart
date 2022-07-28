import 'package:fairplay_ds/core/core_button.dart';
import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/button_theme.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';

class CoreWarning extends StatelessWidget {
  const CoreWarning({
    required this.onPress,
    required this.title,
    required this.description,
    required this.actionText,
    this.buttonType = CoreButtonType.elevated,
    this.buttonSize = CoreButtonSizeType.medium,
    this.buttonPadding = const CoreSpacing(
      top: CoreSpacingType.large,
      horizontal: CoreSpacingType.medium,
    ),
    this.icon,
    this.height,
  });

  const CoreWarning.error({
    required this.onPress,
    this.buttonType = CoreButtonType.elevated,
    this.buttonSize = CoreButtonSizeType.medium,
    this.buttonPadding = const CoreSpacing(
      top: CoreSpacingType.large,
      horizontal: CoreSpacingType.medium,
    ),
    this.icon = const CoreIcon.huge(
      icon: 'assets/images/icons/warning_circle.svg',
      color: CoreColorType.primary,
    ),
    this.title = '',
    this.description =
        'Não foi possível carregar a página. Clique no botão para atualizar.',
    this.actionText = 'Atualizar pagina',
    this.height,
  });

  const CoreWarning.empty({
    this.onPress,
    this.buttonType = CoreButtonType.elevated,
    this.buttonSize = CoreButtonSizeType.medium,
    this.buttonPadding = const CoreSpacing(
      top: CoreSpacingType.large,
      horizontal: CoreSpacingType.medium,
    ),
    this.icon = const CoreIcon.huge(
      icon: 'assets/images/icons/warning_circle.svg',
      color: CoreColorType.primary,
    ),
    this.title = 'Nenhum dado encontrado.',
    this.description = '',
    this.actionText = '',
    this.height,
  });

  final VoidCallback? onPress;
  final CoreButtonType buttonType;
  final CoreButtonSizeType buttonSize;
  final CoreSpacing buttonPadding;
  final Widget? icon;
  final String title;
  final String description;
  final String actionText;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CoreContainer(
      height: height ?? MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CoreContainer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CoreContainer(
                visible: icon != null,
                padding: CoreSpacing(
                  bottom: CoreSpacingType.large,
                ),
                child: icon,
              ),
              CoreContainer(
                visible: title.isNotEmpty,
                padding: CoreSpacing(
                  bottom: CoreSpacingType.small,
                ),
                child: CoreTypography.bodyText1(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
              icon != null ? const CoreContainer.tiny() : SizedBox.shrink(),
              CoreContainer(
                visible: description.isNotEmpty,
                padding: CoreSpacing(
                  horizontal: CoreSpacingType.large,
                ),
                child: CoreTypography.bodyText2Normal(
                  description,
                  color: CoreColorType.neutral500,
                  textAlign: TextAlign.center,
                ),
              ),
              icon != null
                  ? const CoreContainer(
                      padding: CoreSpacing(
                        bottom: CoreSpacingType.medium,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          CoreContainer(
            visible: actionText != '',
            padding: buttonPadding,
            child: CoreButton(
              coreButtonType: buttonType,
              coreButtonSizeType: buttonSize,
              onPress: () async => onPress?.call(),
              content: actionText,
            ),
          ),
        ],
      ),
    );
  }
}
