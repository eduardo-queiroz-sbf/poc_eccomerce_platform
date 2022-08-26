import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';

import '../theme/interfaces/banner_theme.dart';
import '../theme/interfaces/button_theme.dart';
import 'core_button.dart';
import 'core_container.dart';

class CoreBanner extends StatefulWidget {
  const CoreBanner(
      {this.key,
      this.coreBannerType,
      required this.coreBannerSizeType,
      required this.coreBannerOrientationType,
      required this.image,
      required this.title,
      required this.titleContent,
      this.subtitle,
      this.subtitleContent,
      this.anotherSubtitle,
      this.anotherSubtitleContent,
      this.description,
      this.descriptionContent,
      this.button1,
      this.button1Content,
      this.button2,
      this.button2Content,
      required this.height,
      required this.width});
  const CoreBanner.square(
      {this.key,
      this.coreBannerType,
      this.coreBannerSizeType = CoreBannerSizeType.entireScreen,
      required this.image,
      required this.title,
      required this.titleContent,
      this.subtitle,
      this.subtitleContent,
      this.anotherSubtitle,
      this.anotherSubtitleContent,
      this.description,
      this.descriptionContent,
      this.button1,
      this.button1Content,
      this.button2,
      this.button2Content,
      required this.height,
      required this.width})
      : this.coreBannerOrientationType = CoreBannerOrientationType.square;

  const CoreBanner.portrait(
      {this.key,
      this.coreBannerType,
      this.coreBannerSizeType = CoreBannerSizeType.entireScreen,
      required this.image,
      required this.title,
      required this.titleContent,
      this.subtitle,
      this.subtitleContent,
      this.anotherSubtitle,
      this.anotherSubtitleContent,
      this.description,
      this.descriptionContent,
      this.button1,
      this.button1Content,
      this.button2,
      this.button2Content,
      required this.height,
      required this.width})
      : this.coreBannerOrientationType = CoreBannerOrientationType.portrait;

  const CoreBanner.landscape(
      {this.key,
      this.coreBannerType,
      this.coreBannerSizeType = CoreBannerSizeType.entireScreen,
      required this.image,
      required this.title,
      required this.titleContent,
      this.subtitle,
      this.subtitleContent,
      this.anotherSubtitle,
      this.anotherSubtitleContent,
      this.description,
      this.descriptionContent,
      this.button1,
      this.button1Content,
      this.button2,
      this.button2Content,
      required this.height,
      required this.width})
      : this.coreBannerOrientationType = CoreBannerOrientationType.landscape;

  final CoreBannerOrientationType coreBannerOrientationType;
  final CoreBannerType? coreBannerType;
  final CoreBannerSizeType coreBannerSizeType;
  final Widget image;
  final CoreTypography title;
  final String? titleContent;
  final CoreTypography? subtitle;
  final String? subtitleContent;
  final CoreTypography? anotherSubtitle;
  final String? anotherSubtitleContent;
  final CoreTypography? description;
  final String? descriptionContent;
  final CoreButton? button1;
  final String? button1Content;
  final CoreButton? button2;
  final String? button2Content;
  final double width;
  final double height;
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
          currentStyle.image!,
          CoreContainer(
            margin: const CoreSpacing(
                top: CoreSpacingType.large, left: CoreSpacingType.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CoreContainer(
                  padding: CoreSpacing(bottom: CoreSpacingType.small),
                  child: CoreTypography.bodyText2Normal('Subtítulo'),
                ),
                const CoreContainer(
                  
                  padding: CoreSpacing(bottom:
                   CoreSpacingType.small),
                  child: CoreTypography.headline1('TÍTULO'),
                ),
                const CoreContainer(
                  padding: CoreSpacing(bottom: CoreSpacingType.medium),
                  child: CoreTypography.bodyText2Normal('Outro subtítulo'),
                ),
                Row(
                  children: const [
                    CoreButton(
                      content: 'Rótulo',
                      coreButtonType: CoreButtonType.elevated,
                      coreButtonSizeType: CoreButtonSizeType.small,
                    ),
                    CoreContainer(
                      padding: CoreSpacing(left: CoreSpacingType.medium),
                      child: CoreButton(
                        content: 'Rótulo',
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
          currentStyle.image!,
          CoreContainer(
            margin: const CoreSpacing(
                top: CoreSpacingType.large, left: CoreSpacingType.small),
            child: SizedBox(
              width: currentStyle.width!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CoreContainer(
                    padding: CoreSpacing(bottom: CoreSpacingType.small),
                    child: CoreTypography.bodyText1Normal('Subtítulo'),
                  ),
                  const CoreContainer(
                    padding: CoreSpacing(bottom: CoreSpacingType.small),
                    child: CoreTypography.headline1('TÍTULO'),
                  ),
                  const CoreContainer(
                    padding: CoreSpacing(bottom: CoreSpacingType.medium),
                    child: CoreTypography.bodyText1Normal('Outro subtítulo'),
                  ),
                  const CoreContainer(
                    padding: CoreSpacing(bottom: CoreSpacingType.medium),
                    child: CoreTypography.bodyText1Normal(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis ut diam quam nulla porttitor massa id neque aliquam. Enim neque volutpat ac tincidunt. Eu ultrices vitae auctor eu augue. Est lorem ipsum dolor sit. '),
                  ),
                  Row(
                    children: const [
                      CoreButton(
                        content: 'Rótulo',
                        coreButtonType: CoreButtonType.elevated,
                        coreButtonSizeType: CoreButtonSizeType.small,
                      ),
                      CoreContainer(
                        padding: CoreSpacing(left: CoreSpacingType.medium),
                        child: CoreButton(
                          content: 'Rótulo',
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
