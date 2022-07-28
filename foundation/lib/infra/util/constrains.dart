// ignore_for_file: camel_case_types

import 'dart:ui';
import 'package:injectable/injectable.dart';
import 'package:universal_platform/universal_platform.dart';

enum DEVICE_SIZE {
  sm,
  md,
  lg,
}

DEVICE_SIZE _deviceSpec(double width, double height) {
  if (UniversalPlatform.isIOS) {
    if ((width <= 320 && height <= 480) || (width <= 480 && height <= 320)) {
      // iphone 4 spec
      return DEVICE_SIZE.sm;
    } else if ((width <= 320 && height <= 568) ||
        (width <= 568 && height <= 320)) {
      // iphone 5 spec
      return DEVICE_SIZE.sm;
    } else if ((width <= 375 && height <= 667) ||
        (width <= 667 && height <= 375)) {
      // iphone 6 spec
      return DEVICE_SIZE.sm;
    } else if ((width <= 414 && height <= 736) ||
        (width <= 736 && height <= 414)) {
      // iphone 6 plus spec
      return DEVICE_SIZE.md;
    }

    // greater then inphone 6 plus, such as tablets
    return DEVICE_SIZE.lg;
  } else if (UniversalPlatform.isAndroid) {
    // size spec from: https://developer.android.com/guide/practices/screens_support.html
    // xlarge screens are at least 960dp x 720dp
    // large screens are at least 640dp x 480dp
    // normal screens are at least 470dp x 320dp
    // small screens are at least 426dp x 320dp
    if ((width >= 960 && height >= 720) || (width >= 720 && height >= 960)) {
      return DEVICE_SIZE.lg;
    } else if ((width >= 640 && height >= 480) ||
        (width >= 480 && height >= 640)) {
      return DEVICE_SIZE.md;
    } else if ((width >= 470 && height >= 320) ||
        (width >= 320 && height >= 470)) {
      return DEVICE_SIZE.sm;
    } else if ((width >= 426 && height >= 320) ||
        (width >= 320 && height >= 426)) {
      return DEVICE_SIZE.sm;
    }

    return DEVICE_SIZE.md;
  } else {
    final double aspectRatio = width / height;
    if (aspectRatio > 1) {
      return DEVICE_SIZE.sm;
    } else {
      return DEVICE_SIZE.md;
    }
  }
}

@singleton
class ConstrainsContext {
  ConstrainsContext() {
    // Pixel density
    pixelRatio = window.devicePixelRatio;

    //Size in physical pixels
    physicalScreenSize = window.physicalSize;
    physicalWidth = physicalScreenSize.width;
    physicalHeight = physicalScreenSize.height;

    //Size in logical pixels
    logicalScreenSize = window.physicalSize / pixelRatio;
    logicalWidth = logicalScreenSize.width;
    logicalHeight = logicalScreenSize.height;

    //Padding in physical pixels
    padding = window.padding;

    //Safe area paddings in logical pixels
    paddingLeft = window.padding.left / window.devicePixelRatio;
    paddingRight = window.padding.right / window.devicePixelRatio;
    paddingTop = window.padding.top / window.devicePixelRatio;
    paddingBottom = window.padding.bottom / window.devicePixelRatio;

    //Safe area in logical pixels
    safeWidth = logicalWidth - paddingLeft - paddingRight;
    safeHeight = logicalHeight - paddingTop - paddingBottom;

    type = _deviceSpec(safeWidth, safeHeight);
  }

  // Pixel density
  late double pixelRatio;

  //Size in physical pixels
  late Size physicalScreenSize;
  late double physicalWidth;
  late double physicalHeight;

  //Size in logical pixels
  late Size logicalScreenSize;
  late double logicalWidth;
  late double logicalHeight;

  //Padding in physical pixels
  late WindowPadding padding;

  //Safe area paddings in logical pixels
  late double paddingLeft;
  late double paddingRight;
  late double paddingTop;
  late double paddingBottom;

  //Safe area in logical pixels
  late double safeWidth;
  late double safeHeight;

  //breakpoint type
  late DEVICE_SIZE type;
}

class Constrains {
  ConstrainsContext mobileConstrains = ConstrainsContext();

  T getSizeDevice<T>(
    T valueDefault, {
    T? sm,
    T? md,
    T? lg,
  }) {
    switch (mobileConstrains.type) {
      case DEVICE_SIZE.sm:
        return sm ?? valueDefault;
      case DEVICE_SIZE.md:
        return md ?? valueDefault;
      case DEVICE_SIZE.lg:
        return lg ?? md ?? valueDefault;
    }
  }

  double get fullHeight => mobileConstrains.safeHeight;
  double get fullWidth => mobileConstrains.safeWidth;
  double width(
    double widthPercent, {
    double? sm,
    double? md,
    double? lg,
  }) =>
      (mobileConstrains.safeWidth / 100) *
      getSizeDevice(
        widthPercent,
        sm: sm,
        md: md,
        lg: lg,
      );

  double height(
    double heightPercent, {
    double? sm,
    double? md,
    double? lg,
  }) =>
      (mobileConstrains.safeHeight / 100) *
      getSizeDevice(
        heightPercent,
        sm: sm,
        md: md,
        lg: lg,
      );

  double aspectRatio(
    double proportion, {
    double? sm,
    double? md,
    double? lg,
  }) =>
      mobileConstrains.safeWidth /
      (mobileConstrains.safeHeight /
          getSizeDevice(
            proportion,
            sm: sm,
            md: md,
            lg: lg,
          ));
}
