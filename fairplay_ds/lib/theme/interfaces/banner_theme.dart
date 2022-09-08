import 'package:flutter/material.dart';
import 'package:fairplay_ds/theme/interfaces/mapper_theme.dart';

enum CoreBannerType {
  contentInsideImage("content-inside-image"),
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

// class CoreBannerMapper {
//   CoreBannerMapper({
//     required Map<CoreBannerType, CoreBannerThemeData> type,
//     required Map<CoreBannerOrientationType, CoreBannerThemeData> orientation,
//   }) : values = <CoreBannerType,
//             Map<CoreBannerOrientationType, CoreBannerThemeData>>{
//           CoreBannerType.contentInsideImage:
//               <CoreBannerOrientationType, CoreBannerThemeData>{
//             CoreBannerOrientationType.landscape:
//                 type[CoreBannerType.contentInsideImage]!
//                     .merge(orientation[CoreBannerOrientationType.landscape]),
//             CoreBannerOrientationType.square:
//                 type[CoreBannerType.contentInsideImage]!
//                     .merge(orientation[CoreBannerOrientationType.square]),
//             CoreBannerOrientationType.portrait:
//                 type[CoreBannerType.contentInsideImage]!
//                     .merge(orientation[CoreBannerOrientationType.portrait]),
//           },
//           CoreBannerType.contentOutsideImage:
//               <CoreBannerOrientationType, CoreBannerThemeData>{
//             CoreBannerOrientationType.landscape:
//                 type[CoreBannerType.contentOutsideImage]!
//                     .merge(orientation[CoreBannerOrientationType.landscape]),
//             CoreBannerOrientationType.square:
//                 type[CoreBannerType.contentOutsideImage]!
//                     .merge(orientation[CoreBannerOrientationType.square]),
//             CoreBannerOrientationType.portrait:
//                 type[CoreBannerType.contentOutsideImage]!
//                     .merge(orientation[CoreBannerOrientationType.portrait]),
//           },
//         };

//   final Map<CoreBannerType, Map<CoreBannerOrientationType, CoreBannerThemeData>>
//       values;
// }

class CoreBannerMapper {
  CoreBannerMapper({
    required Map<CoreBannerType, CoreBannerThemeData> type,
    required Map<CoreBannerSizeType, CoreBannerThemeData> size,
  }) : values = <CoreBannerType, Map<CoreBannerSizeType, CoreBannerThemeData>>{
          CoreBannerType.contentInsideImage:
              <CoreBannerSizeType, CoreBannerThemeData>{
            CoreBannerSizeType.carousel: type[CoreBannerType.contentInsideImage]!
                .merge(size[CoreBannerSizeType.carousel]),
            CoreBannerSizeType.entireScreen: type[CoreBannerType.contentInsideImage]!
                .merge(size[CoreBannerSizeType.entireScreen]),
            CoreBannerSizeType.halfScreen: type[CoreBannerType.contentInsideImage]!
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
    this.imageWidth,
    this.imageHeight,
    this.titleStyle,
    this.subtitleStyle,
    this.anotherSubtitleStyle,
    this.descriptionStyle,
    this.sizeType,
    this.type,
    this.orientationType,
    // this.button1Style,
    // this.button2Style,
  });

  CoreBannerThemeData merge(CoreBannerThemeData? style) {
    if (style == null) return this;
    return CoreBannerThemeData(
      imageWidth: style.imageWidth ?? 0.0,
      imageHeight: style.imageHeight ?? 0.0,
      titleStyle: style.titleStyle ?? const TextStyle(),
      subtitleStyle: style.subtitleStyle ?? const TextStyle(),
      anotherSubtitleStyle: style.anotherSubtitleStyle ?? const TextStyle(),
      descriptionStyle: style.descriptionStyle ?? const TextStyle(),
      sizeType: style.sizeType,
      type: style.type,
      orientationType: style.orientationType
      // button1Style: style.button1Style ?? const ButtonStyle(),
      // button2Style: style.button2Style ?? const ButtonStyle(),
    );
  }

  final double? imageWidth;
  final double? imageHeight;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? anotherSubtitleStyle;
  final TextStyle? descriptionStyle;
  final CoreBannerSizeType? sizeType;
  final CoreBannerType? type;
  final CoreBannerOrientationType? orientationType;
  // final ButtonStyle? button1Style;
  // final ButtonStyle? button2Style;

  CoreBannerThemeData copyWith({
    final double? imageWidth,
    final double? imageHeight,
    final TextStyle? titleStyle,
    final TextStyle? subtitleStyle,
    final TextStyle? anotherSubtitleStyle,
    final TextStyle? descriptionStyle,
    final ButtonStyle? button1Style,
    final ButtonStyle? button2Style,
    final CoreBannerSizeType? sizeType,
    final CoreBannerType? type,
    final CoreBannerOrientationType? orientationType,
  }) {
    return CoreBannerThemeData(
      imageWidth: this.imageWidth,
      imageHeight: this.imageHeight,
      titleStyle: this.titleStyle,
      subtitleStyle: this.subtitleStyle,
      anotherSubtitleStyle: this.anotherSubtitleStyle,
      descriptionStyle: this.descriptionStyle,
      sizeType: this.sizeType,
      type: this.type,
      orientationType: this.orientationType
      // button1Style: this.button1Style,
      // button2Style: this.button2Style,
    );
  }
}

// class CoreBannerTheme extends ThemeExtension<CoreBannerTheme>
//     with MapperThemeBehavior<CoreBannerTheme> {
//   CoreBannerTheme(CoreBannerMapper bannerMapper)
//       : this.values = bannerMapper.values;

//   final Map<CoreBannerType,
//       Map<CoreBannerOrientationType, CoreBannerThemeData>> values;
// }

// class CoreBannerTheme extends ThemeExtension<CoreBannerTheme>
//     with MapperThemeBehavior<CoreBannerTheme> {
//   CoreBannerTheme({
//     required this.values,
//   });

//   final Map<CoreBannerType, CoreBannerThemeData> values;
// }

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
