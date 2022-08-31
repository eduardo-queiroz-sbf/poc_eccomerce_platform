import 'package:flutter/material.dart';
import 'package:fairplay_ds/theme/interfaces/mapper_theme.dart';

enum CoreBannerType {
  imageContent("content-inside-image"),
  contentOutsideImage("content-outside-image");

  final String name;
  const CoreBannerType(this.name);
}

enum CoreBannerSizeType {
  entireScreen("entire-screen"),
  carousel("carousel"),
  halfScreen("half-screen"),
  small("small");

  final String name;
  const CoreBannerSizeType(this.name);
}

enum CoreBannerOrientationType {
  square("square"),
  portrait("portrait"),
  landscape("landscape");

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
    this.title = '',
    this.subtitle,
    this.anotherSubtitle,
    this.description,
    this.button1,
    this.button2,
  });

  CoreBannerThemeData merge(CoreBannerThemeData? style) {
    if (style == null) return this;
    return CoreBannerThemeData(
      image: style.image,
      width: style.width ?? 0.0,
      height: style.height ?? 0.0,
      title: style.title,
      subtitle: style.subtitle ?? '',
      anotherSubtitle: style.anotherSubtitle ?? '',
      description: style.description ?? '',
      button1: button1 ?? '',
      button2: button2 ?? '',
    );
  }

  final Widget? image;
  final double? width;
  final double? height;
  final String title;
  final String? subtitle;
  final String? anotherSubtitle;
  final String? description;
  final String? button1;
  final String? button2;

  CoreBannerThemeData copyWith({
    final Widget? image,
    final double? width,
    final double? height,
    final String title = '',
    final String? subtitle,
    final String? anotherSubtitle,
    final String? description,
    final String? button1,
    final String? button2,
  }) {
    return CoreBannerThemeData(
      image: this.image,
      width: this.width,
      height: this.height,
      title: this.title,
      subtitle: this.subtitle,
      anotherSubtitle: this.anotherSubtitle,
      description: this.description,
      button1: this.button1,
      button2: this.button2,
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
