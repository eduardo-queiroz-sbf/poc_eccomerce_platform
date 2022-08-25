import 'package:fairplay_ds/theme/interfaces/button_theme.dart';
import 'package:fairplay_ds/theme/interfaces/typography_theme.dart';
import 'package:flutter/material.dart';
import 'package:fairplay_ds/theme/interfaces/mapper_theme.dart';

enum CoreBannerType {
  imageContent("Content inside image"),
  contentOutsideImage("Content outside image");

  final String name;
  const CoreBannerType(this.name);
}

enum CoreBannerSizeType {
  entireScreen("Entire Screen"),
  carousel("Carousel"),
  halfScreen("Half Screen"),
  small("Small");

  final String name;
  const CoreBannerSizeType(this.name);
}

enum CoreBannerOrientationType {
  square("Square"),
  portrait("Portrait"),
  landscape("Landscape");

  final String name;
  const CoreBannerOrientationType(this.name);
}

class CoreBannerMapper {
  CoreBannerMapper({
    required Map<CoreBannerType, CoreBannerThemeData> type,
    required Map<CoreBannerSizeType, CoreBannerThemeData> size,
  }) : values = <CoreBannerType, Map<CoreBannerSizeType, CoreBannerThemeData>>{
          CoreBannerType.imageContent:
              <CoreBannerSizeType, CoreBannerThemeData>{
            CoreBannerSizeType.carousel: type[CoreBannerType.imageContent]!
                .merge(size[CoreBannerSizeType.carousel]),
            CoreBannerSizeType.entireScreen: type[CoreBannerType.imageContent]!
                .merge(size[CoreBannerSizeType.entireScreen]),
            CoreBannerSizeType.halfScreen: type[CoreBannerType.imageContent]!
                .merge(size[CoreBannerSizeType.halfScreen]),
          },
          CoreBannerType.contentOutsideImage:
              <CoreBannerSizeType, CoreBannerThemeData>{
            CoreBannerSizeType.carousel:
                type[CoreBannerType.contentOutsideImage]!
                    .merge(size[CoreBannerSizeType.carousel]),
            CoreBannerSizeType.entireScreen:
                type[CoreBannerType.contentOutsideImage]!
                    .merge(size[CoreBannerSizeType.entireScreen]),
            CoreBannerSizeType.halfScreen:
                type[CoreBannerType.contentOutsideImage]!
                    .merge(size[CoreBannerSizeType.halfScreen]),
            CoreBannerSizeType.small: type[CoreBannerType.contentOutsideImage]!
                .merge(size[CoreBannerSizeType.small]),
          },
        };

  final Map<CoreBannerType, Map<CoreBannerSizeType, CoreBannerThemeData>>
      values;
}

class CoreBannerThemeData {
  CoreBannerThemeData({
    this.image,
    this.width,
    this.height,
    this.title,
    this.titleContent,
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
  });

  CoreBannerThemeData merge(CoreBannerThemeData? style) {
    if (style == null) return this;
    return CoreBannerThemeData(
      image: style.image,
      width: style.width ?? 0.0,
      height: style.height ?? 0.0,
      title: style.title,
      titleContent: style.titleContent,
      subtitle: subtitle ?? style.subtitle,
      subtitleContent: subtitleContent ?? style.subtitleContent,
      anotherSubtitle: anotherSubtitle ?? style.anotherSubtitle,
      anotherSubtitleContent:
          anotherSubtitleContent ?? style.anotherSubtitleContent,
      description: description ?? style.description,
      descriptionContent: descriptionContent ?? style.descriptionContent,
      button1: button1 ?? style.button1,
      button1Content: button1Content ?? button1Content,
      button2: button2 ?? style.button2,
      button2Content: button2Content ?? button2Content,
    );
  }

  final Widget? image;
  final double? width;
  final double? height;
  final CoreTypographyThemeData? title;
  final String? titleContent;
  final CoreTypographyThemeData? subtitle;
  final String? subtitleContent;
  final CoreTypographyThemeData? anotherSubtitle;
  final String? anotherSubtitleContent;
  final CoreTypographyThemeData? description;
  final String? descriptionContent;
  final CoreButtonTheme? button1;
  final String? button1Content;
  final CoreButtonTheme? button2;
  final String? button2Content;

  CoreBannerThemeData copyWith({
    final Widget? image,
    final double? width,
    final double? height,
    final CoreTypographyThemeData? title,
    final String? titleContent,
    final CoreTypographyThemeData? subtitle,
    final String? subtitleContent,
    final CoreTypographyThemeData? anotherSubtitle,
    final String? anotherSubtitleContent,
    final CoreTypographyThemeData? description,
    final String? descriptionContent,
    final CoreButtonTheme? button1,
    final String? button1Content,
    final CoreButtonTheme? button2,
    final String? button2Content,
  }) {
    return CoreBannerThemeData(
      image: this.image,
      width: this.width,
      height: this.height,
      title: this.title,
      titleContent: titleContent,
      subtitle: subtitle ?? this.subtitle,
      subtitleContent: subtitleContent ?? this.subtitleContent,
      anotherSubtitle: anotherSubtitle ?? this.anotherSubtitle,
      anotherSubtitleContent:
          anotherSubtitleContent ?? this.anotherSubtitleContent,
      description: description ?? this.description,
      descriptionContent: descriptionContent ?? this.descriptionContent,
      button1: button1 ?? this.button1,
      button1Content: button1Content ?? this.button1Content,
      button2: button2 ?? this.button2,
      button2Content: button2Content ?? this.button2Content,
    );
  }
}

class CoreBannerTheme extends ThemeExtension<CoreBannerTheme>
    with MapperThemeBehavior<CoreBannerTheme> {
  CoreBannerTheme(
      {required Map<CoreBannerType, CoreBannerThemeData> type,
      required Map<CoreBannerSizeType, CoreBannerThemeData> size})
      : values = {
          CoreBannerOrientationType.square:
              CoreBannerMapper(size: size, type: type).values,
          CoreBannerOrientationType.portrait:
              CoreBannerMapper(size: size, type: type).values,
          CoreBannerOrientationType.landscape:
              CoreBannerMapper(size: size, type: type).values,
        };

  final Map<CoreBannerOrientationType,
      Map<CoreBannerType, Map<CoreBannerSizeType, CoreBannerThemeData>>> values;
}
