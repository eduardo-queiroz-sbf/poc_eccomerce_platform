import 'package:flutter/material.dart';

class CoreFontSize {
  double get mini => 12.0;
  double get xtiny => 14.0;
  double get tiny => 16.0;
  double get small => 18.0;
  double get xsmall => 20.0;
  double get medium => 24.0;
  double get large => 32.0;
  double get xlarge => 40.0;
  double get huge => 48.0;
  double get xhuge => 72.0;
}

class CoreFontWeight {
  FontWeight get regular => FontWeight.w400;
  FontWeight get medium => FontWeight.w500;
  FontWeight get bold => FontWeight.w700;
  FontWeight get xbold => FontWeight.w800;
}

class CoreLetterSpacing {
  double get tight => -0.8;
  double get normal => 0.0;
}

class CoreLineHeight {
  double get tight => 0.9;
  double get small => 1.2;
  double get large => 1.5;
}

class CoreLayoutZIndex {
  double get tiny => 100.0;
  double get small => 200.0;
  double get medium => 300.0;
  double get large => 400.0;
  double get huge => 500.0;
}

class CoreBorderRadius {
  double get none => 0.0;
  double get small => 2.0;
  double get medium => 4.0;
  double get large => 8.0;
  double get xlarge => 16.0;
  double get huge => 24.0;
  double get circular => 200.0;
}

class CoreBorderWidth {
  double get none => 0.0;
  double get xthin => 1.0;
  double get thin => 2.0;
  double get small => 4.0;
}

class CoreSpacingSize {
  double get spacing25 => 2.0;
  double get spacing50 => 4.0;
  double get spacing100 => 8.0;
  double get spacing200 => 16.0;
  double get spacing300 => 24.0;
  double get spacing400 => 32.0;
  double get spacing500 => 40.0;
  double get spacing600 => 48.0;
  double get spacing700 => 56.0;
  double get spacing800 => 64.0;
  double get spacing900 => 72.0;
  double get spacing1000 => 80.0;
  double get spacing1100 => 96.0;
  double get spacing1200 => 104.0;
  double get spacing1300 => 112.0;
  double get spacing1400 => 120.0;
}

class CoreOpacity {
  double get opacity0 => 0.0;
  double get opacity100 => 0.08;
  double get opacity200 => 0.16;
  double get opacity300 => 0.24;
  double get opacity400 => 0.48;
  double get opacity500 => 0.64;
  double get opacity600 => 0.96;
  double get opacity1000 => 1;
}

class CoreShadow {
  BoxShadow get shadow100 => const BoxShadow(
      blurRadius: 4.0,
      spreadRadius: 2.0,
      offset: Offset(0.0, 0.0),
      color: Color.fromRGBO(17, 17, 17, 0.16));
  BoxShadow get shadow200 => const BoxShadow(
      blurRadius: 16.0,
      spreadRadius: 4.0,
      offset: Offset(0.0, 0.0),
      color: Color.fromRGBO(17, 17, 17, 0.16));
  BoxShadow get shadow300 => const BoxShadow(
      blurRadius: 16.0,
      spreadRadius: 4.0,
      offset: Offset(0.0, 0.0),
      color: Color.fromRGBO(17, 17, 17, 0.24));
  BoxShadow get shadow400 => const BoxShadow(
      blurRadius: 24.0,
      spreadRadius: 8.0,
      offset: Offset(0.0, 0.0),
      color: Color.fromRGBO(17, 17, 17, 0.24));
  BoxShadow get shadow500 => const BoxShadow(
      blurRadius: 32.0,
      spreadRadius: 16.0,
      offset: Offset(0.0, 0.0),
      color: Color.fromRGBO(17, 17, 17, 0.48));
}

class CoreColorScheme {
  // primary colors
  Color get primary => const Color(0xFFFFFFFF);

  //secondary colors
  Color get secondary => const Color(0xFFDCE6E6);

  // success colors
  //100
  Color get successLightest => const Color(0xFF82C69B);
  //200
  Color get success => const Color(0xFF2D8656);
  //300
  Color get successDark => const Color(0xFF2E6344);

  // negative colors
  //100
  Color get negative100 => const Color(0xFFEEA598);
  //200
  Color get negative200 => const Color(0xFFDD3728);
  //300
  Color get negative300 => const Color(0xFFA72A1E);

  LinearGradient get negativeLight => const LinearGradient(colors: [
        Color(0xFFE7EDF1),
        Color(0xFFF8F8F8),
        Color(0xFFE7EDF1),
      ]);

  LinearGradient get negativeDark => const LinearGradient(colors: [
        Color(0xFF232323),
        Color(0xFF959595),
        Color(0xFF232323),
      ]);

  // alert colors
  //100
  Color get alertLightest => const Color(0xFFFAA273);
  //200
  Color get alert => const Color(0xFFBF5920);
  //300
  Color get alertDark => const Color(0xFF894723);

  // informative colors
  //100
  Color get informativeLightest => const Color(0xFF96BAE7);
  //200
  Color get informative => const Color(0xFF2677D0);
  //300
  Color get informativeDark => const Color(0xFF2E5A8F);

  // neutral colors

  //100
  Color get neutralWhite => const Color(0xFFFFFFFF);
  Color get neutral200 => const Color(0xFFF3F3F3);
  Color get neutral300 => const Color(0xFFD2D2D2);
  Color get neutral400 => const Color(0xFF959595);
  Color get neutral500 => const Color(0xFF767676);
  Color get neutral600 => const Color(0xFF6F6F6F);
  //700
  Color get neutralBlack => const Color(0xFF111111);
}

// class CoreIconSize {
//   double get none => 0.0;
//   double get tiny => 16;
//   double get small => 20;
//   double get medium => 24;
//   double get large => 36;
//   double get huge => 64;
// }