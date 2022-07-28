import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';

class CoreSelectableTag extends StatelessWidget {
  const CoreSelectableTag({
    Key? key,
    required this.child,
    required this.onPress,
    this.height = 40,
    this.icon,
    this.showIcon = true,
    this.value = false,
  }) : super(key: key);

  final Widget child;
  final Function(bool) onPress;
  final double? height;
  final IconData? icon;
  final bool showIcon;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress(value);
      },
      child: CoreContainer(
        height: height,
        bordered: true,
        borderColor: value ? CoreColorType.primary : CoreColorType.neutral300,
        padding: const CoreSpacing(
          horizontal: CoreSpacingType.small,
        ),
        margin: const CoreSpacing(
          right: CoreSpacingType.small,
          bottom: CoreSpacingType.small,
        ),
        child: Wrap(
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            child,
            CoreContainer(
              visible: (icon != null || value) && showIcon,
              padding: const CoreSpacing(
                left: CoreSpacingType.tiny,
              ),
              child: CoreIcon(
                icon: icon ?? Icons.close,
                color: CoreColorType.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
