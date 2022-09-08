import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:fairplay_ds/theme/interfaces/typography_theme.dart';
import 'package:flutter/material.dart';

import '../theme/interfaces/banner_theme.dart';
import '../theme/interfaces/button_theme.dart';
import 'core_button.dart';
import 'core_container.dart';

class CoreBanner extends StatefulWidget {
  const CoreBanner({
    this.key,
    required this.coreBannerType,
    required this.coreBannerSizeType,
    required this.coreBannerOrientationType,
    required this.image,
    required this.title,
    this.subtitle = '',
    this.anotherSubtitle = '',
    this.description = '',
    this.button1 = '',
    this.button2 = '',
  });
  const CoreBanner.square({
    this.key,
    required this.coreBannerType,
    required this.coreBannerSizeType,
    required this.image,
    required this.title,
    this.subtitle = '',
    this.anotherSubtitle = '',
    this.description = '',
    this.button1 = '',
    this.button2 = '',
  }) : this.coreBannerOrientationType = CoreBannerOrientationType.square;

  const CoreBanner.portrait({
    this.key,
    required this.coreBannerType,
    required this.coreBannerSizeType,
    required this.image,
    required this.title,
    this.subtitle = '',
    this.anotherSubtitle = '',
    this.description = '',
    this.button1 = '',
    this.button2 = '',
  }) : coreBannerOrientationType = CoreBannerOrientationType.portrait;

  const CoreBanner.landscape(
      {this.key,
      required this.coreBannerType,
      required this.coreBannerSizeType,
      required this.image,
      required this.title,
      this.subtitle = '',
      this.anotherSubtitle = '',
      this.description = '',
      this.button1 = '',
      this.button2 = ''})
      : coreBannerOrientationType = CoreBannerOrientationType.landscape;

  final CoreBannerOrientationType coreBannerOrientationType;
  final CoreBannerType coreBannerType;
  final CoreBannerSizeType coreBannerSizeType;
  final Widget image;
  final String title;
  final String subtitle;
  final String anotherSubtitle;
  final String description;
  final String button1;
  final String button2;
  final Key? key;

  @override
  State<CoreBanner> createState() => _CoreBannerState();
}

class _CoreBannerState extends State<CoreBanner> {
  CoreBannerThemeData _getThemedStyle(BuildContext context) {
    return Theme.of(context)
                .extension<CoreBannerTheme>()!
                .values[widget.coreBannerOrientationType]
            ?[widget.coreBannerSizeType]?[widget.coreBannerType] ??
        CoreBannerThemeData();
  }

  @override
  Widget build(BuildContext context) {
    final CoreBannerThemeData currentStyle = _getThemedStyle(context);
    if (widget.coreBannerType == CoreBannerType.contentOutsideImage) {
      Stack(
        children: [
          widget.image,
          CoreContainer(
            margin: const CoreSpacing(
                top: CoreSpacingType.large, left: CoreSpacingType.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CoreContainer(
                  padding: const CoreSpacing(bottom: CoreSpacingType.small),
                  child: CoreTypography(
                    widget.subtitle,
                    type: CoreTextType.bodyText2Normal,
                  ),
                ),
                CoreContainer(
                  padding: const CoreSpacing(bottom: CoreSpacingType.small),
                  child: CoreTypography(
                    widget.title,
                    type: CoreTextType.headline1,
                  ),
                ),
                CoreContainer(
                  padding: const CoreSpacing(bottom: CoreSpacingType.medium),
                  child: CoreTypography(
                    widget.anotherSubtitle,
                    type: CoreTextType.bodyText2Normal,
                  ),
                ),
                Row(
                  children: [
                    CoreButton(
                      content: widget.button1,
                      coreButtonType: CoreButtonType.elevated,
                      coreButtonSizeType: CoreButtonSizeType.small,
                    ),
                    CoreContainer(
                      padding: const CoreSpacing(left: CoreSpacingType.medium),
                      child: CoreButton(
                        content: widget.button2,
                        coreButtonType: CoreButtonType.elevated,
                        coreButtonSizeType: CoreButtonSizeType.small,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    }
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.image,
          CoreContainer(
            margin: const CoreSpacing(
                top: CoreSpacingType.large, left: CoreSpacingType.small),
            child: SizedBox(
              width: currentStyle.imageWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoreContainer(
                    padding: const CoreSpacing(bottom: CoreSpacingType.small),
                    child: CoreTypography(widget.subtitle,
                        type: CoreTextType.bodyText2Normal,
                        textStyle: currentStyle.subtitleStyle),
                  ),
                  CoreContainer(
                    padding: const CoreSpacing(bottom: CoreSpacingType.small),
                    child: CoreTypography(widget.title,
                        type: CoreTextType.headline1,
                        textStyle: currentStyle.titleStyle),
                  ),
                  CoreContainer(
                    padding: const CoreSpacing(bottom: CoreSpacingType.medium),
                    child: CoreTypography(widget.anotherSubtitle,
                        type: CoreTextType.bodyText2Normal,
                        textStyle: currentStyle.anotherSubtitleStyle),
                  ),
                  CoreContainer(
                    padding: const CoreSpacing(bottom: CoreSpacingType.medium),
                    child: CoreTypography(widget.description,
                        type: CoreTextType.bodyText1Normal,
                        textStyle: currentStyle.descriptionStyle),
                  ),
                  Row(
                    children: [
                      CoreButton(
                        content: widget.button1,
                        coreButtonType: CoreButtonType.elevated,
                        coreButtonSizeType: CoreButtonSizeType.small,
                      ),
                      CoreContainer(
                        padding:
                            const CoreSpacing(left: CoreSpacingType.medium),
                        child: CoreButton(
                          content: widget.button2,
                          coreButtonType: CoreButtonType.elevated,
                          coreButtonSizeType: CoreButtonSizeType.small,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
