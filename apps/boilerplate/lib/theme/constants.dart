import 'package:flutter/material.dart';

class CoreIconSize {
  double get none => 0.0;
  double get tiny => 16;
  double get small => 20;
  double get medium => 24;
  double get large => 36;
  double get huge => 64;
}

class CoreSpacingSize {
  double get none => 0.0;
  double get tiny => 4.0;
  double get small => 8.0;
  double get medium => 16.0;
  double get large => 32.0;
  double get huge => 64.0;
}

class CoreFontSize {
  double get headline1 => 64.0;
  double get headline2 => 48.0;
  double get headline3 => 40.0;
  double get headline4 => 32.0;
  double get headline5 => 24.0;
  double get headline6 => 18.0;
  double get bodyText1 => 16.0;
  double get bodyText2 => 14.0;
  double get caption => 12.0;
}

class CoreRadius {
  double get small => 2.0;
  double get medium => 5.0;
  double get large => 8.0;
  double get circular => 200.0;
}

class CoreShadow {
  BoxShadow get tinyUp => const BoxShadow(
        blurRadius: 3.0,
        offset: Offset(0.0, -2.0),
      );
}

class CoreColorScheme {
  // primary colors
  Color get primary => const Color(0xFFE30000);
  Color get primaryDark => const Color(0xFF8C0000);
  Color get primaryLight => const Color(0xFFF56262);
  Color get primaryLightest => const Color(0xFFFFDBDB);
  //secondary colors
  Color get secondary => const Color(0xFF00AD1D);
  Color get secondaryDark => const Color(0xFF006611);
  Color get secondaryLight => const Color(0xFF62F47A);
  Color get secondaryLightest => const Color(0xFFDBFFE1);
  // alert colors
  Color get alert => const Color(0xFFFFBA47);
  Color get alertLightest => const Color(0xFFFFF8EB);
  Color get alertDark => const Color(0xFF8C5900);
  // informative colors
  Color get informative => const Color(0xFF47B7FF);
  Color get informativeLightest => const Color(0xFFDBF1FF);
  Color get informativeDark => const Color(0xFF00548C);
  // error colors
  Color get error => const Color(0xFFFF0F0F);
  Color get errorLightest => const Color(0xFFFFDBDB);
  Color get errorDark => const Color(0xFF8C0000);
  // success colors
  Color get success => const Color(0xFF00AD1D);
  Color get successLightest => const Color(0xFFDBFFE1);
  Color get successDark => const Color(0xFF006611);
  // neutral colors
  Color get neutralBlack => const Color(0xFF1A1A1A);
  Color get neutralWhite => const Color(0xFFFFFFFF);
  Color get neutral200 => const Color(0xFFF7F7F7);
  Color get neutral300 => const Color(0xFFD6D6D6);
  Color get neutral400 => const Color(0xFF999999);
  Color get neutral500 => const Color(0xFF737373);
  Color get neutral600 => const Color(0xFF4D4D4D);

  // overlay
  Color get overlay => const Color(0xEE000000);
}
