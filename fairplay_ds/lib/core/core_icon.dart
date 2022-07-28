import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/icon_theme.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoreIcon extends StatelessWidget {
  const CoreIcon({
    this.icon,
    this.iconSize = CoreIconSizeType.small,
    this.color = CoreColorType.neutral600,
    this.onPressed,
  });

  const CoreIcon.tiny({
    this.icon,
    this.iconSize = CoreIconSizeType.tiny,
    this.color = CoreColorType.neutral600,
    this.onPressed,
  });

  const CoreIcon.small({
    this.icon,
    this.iconSize = CoreIconSizeType.small,
    this.color = CoreColorType.neutral600,
    this.onPressed,
  });

  const CoreIcon.medium({
    this.icon,
    this.iconSize = CoreIconSizeType.medium,
    this.color = CoreColorType.neutral600,
    this.onPressed,
  });

  const CoreIcon.large({
    this.icon,
    this.iconSize = CoreIconSizeType.large,
    this.color = CoreColorType.neutral600,
    this.onPressed,
  });

  const CoreIcon.huge({
    this.icon,
    this.iconSize = CoreIconSizeType.huge,
    this.color = CoreColorType.neutral600,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final CoreColorType? color;
  final CoreIconSizeType? iconSize;
  final dynamic icon;

  static final IconData arrowBackRounded =
      getByPlatform(Icons.arrow_back_rounded, Icons.arrow_back_ios_rounded);

  static IconData getByPlatform(IconData androidIcon, IconData iosIcon) {
    if (UniversalPlatform.isAndroid) {
      return androidIcon;
    }

    return iosIcon;
  }

  Widget _typeIcon(Color? currentColor, double? iconSize) {
    if (icon is IconData) {
      return Icon(icon, color: currentColor, size: iconSize);
    } else if (icon is String) {
      return SvgPicture.asset(
        icon!,
        color: currentColor,
        width: iconSize,
        height: iconSize,
      );
    } else {
      return SizedBox(width: iconSize, height: iconSize);
    }
  }

  Color? _getThemedColor(BuildContext context) {
    return Theme.of(context).extension<CoreColorTheme>()!.values[color] ?? null;
  }

  double? _getThemedStyle(BuildContext context) {
    return Theme.of(context).extension<CoreIconSizeTheme>()!.values[iconSize] ??
        null;
  }

  @override
  Widget build(BuildContext context) {
    Color? _currentColor = _getThemedColor(context);
    double? _iconSize = _getThemedStyle(context);
    Widget _currentIcon = _typeIcon(_currentColor, _iconSize);
    return onPressed == null
        ? _currentIcon
        : IconButton(
            padding: EdgeInsets.all(0.0),
            iconSize: _iconSize ?? 16,
            icon: _currentIcon,
            onPressed: onPressed,
          );
  }
}
