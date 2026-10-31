import 'package:flutter/material.dart';

/// Weathera brand palette — a sky blue primary with a neutral ramp.
abstract class WeatheraPalette {
  static const Color brandPrimary = Color(0xFF2F80ED);
  static const Color brandPrimaryDark = Color(0xFF1C64C8); // pressed/active
  static const Color brandPrimaryLight = Color(0xFFE3EEFD); // tint backgrounds
  static const Color sunny = Color(0xFFFFB627);
  static const Color rainy = Color(0xFF5B8DEF);

  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral500 = Color(0xFF9CA3AF);
  static const Color neutral600 = Color(0xFF6B7280);
  static const Color charcoal = Color(0xFF111827);
}

abstract class AppColorScheme {
  Color get primaryColor;
  Color get secondaryColor;
  Color get accentColor => WeatheraPalette.brandPrimary;
  Color get errorColor => const Color(0xffff5959);
  Color get placeholderColor;
  Color get inputBorderColor;
  Color get dividerColor;
  Color get primaryFontColor;
  Color get secondaryFontColor;
  Color get cardBackgroundColor;
  Color get backgroundColor;
  Color get backgroundAccentColor;
  Color get iconTintColor;
  Color get buttonBackgroundColor;
  Color get elevatedButtonTextColor;
  Color get outlineButtonTextColor;
  Color get appBarIconColor;
  Color get appBarColor;
  Color get fieldBackgroundColor => WeatheraPalette.neutral100;

  Color get secondaryCardBackgroundColor;
  Color get infoTextColor;
}

class AppDarkColorScheme extends AppColorScheme {
  @override
  Color get primaryColor => WeatheraPalette.brandPrimary;

  @override
  Color get backgroundColor => const Color(0xff0f172a);

  @override
  Color get buttonBackgroundColor => primaryColor;

  @override
  Color get elevatedButtonTextColor => const Color(0xffFFFFFF);

  @override
  Color get outlineButtonTextColor => const Color(0xffFFFFFF);

  @override
  Color get cardBackgroundColor => const Color(0xff1e293b);

  @override
  Color get secondaryCardBackgroundColor => const Color(0xff334155);

  @override
  Color get dividerColor => const Color(0xff334155);

  @override
  Color get iconTintColor => const Color(0xffffffff);

  @override
  Color get inputBorderColor => const Color(0xff475569);

  @override
  Color get placeholderColor => const Color(0xff94a3b8);

  @override
  Color get primaryFontColor => const Color(0xffffffff);

  @override
  Color get secondaryColor => WeatheraPalette.sunny;

  @override
  Color get accentColor => primaryColor;

  @override
  Color get secondaryFontColor => const Color(0xffe2e8f0);

  @override
  Color get infoTextColor => const Color(0xff94a3b8);

  @override
  Color get appBarIconColor => const Color(0xffffffff);

  @override
  Color get backgroundAccentColor => const Color(0xff1e293b);

  @override
  Color get appBarColor => const Color(0xff0f172a);
}

class AppLightColorScheme extends AppColorScheme {
  @override
  Color get primaryColor => WeatheraPalette.brandPrimary;

  @override
  Color get backgroundColor => const Color(0xFFF7F9FC);

  @override
  Color get buttonBackgroundColor => primaryColor;

  @override
  Color get elevatedButtonTextColor => const Color(0xffFFFFFF);

  @override
  Color get outlineButtonTextColor => primaryColor;

  @override
  Color get cardBackgroundColor => const Color(0xffffffff);

  @override
  Color get secondaryCardBackgroundColor => WeatheraPalette.neutral100;

  @override
  Color get dividerColor => WeatheraPalette.neutral200;

  @override
  Color get iconTintColor => WeatheraPalette.neutral600;

  @override
  Color get inputBorderColor => WeatheraPalette.neutral300;

  @override
  Color get placeholderColor => WeatheraPalette.neutral500;

  @override
  Color get primaryFontColor => WeatheraPalette.charcoal;

  @override
  Color get secondaryColor => WeatheraPalette.sunny;

  @override
  Color get accentColor => primaryColor;

  @override
  Color get secondaryFontColor => const Color(0xff4b5563);

  @override
  Color get infoTextColor => const Color(0xff979797);

  @override
  Color get appBarIconColor => WeatheraPalette.charcoal;

  @override
  Color get backgroundAccentColor => const Color(0xffffffff);

  @override
  Color get appBarColor => const Color(0xFFF7F9FC);
}
