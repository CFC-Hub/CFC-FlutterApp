import 'package:flutter/material.dart';

class CFCAppColors {
  static const int _appPrimaryColorValue = 0xFF40B858;
  static const Color appPrimaryColor = Color(_appPrimaryColorValue);
  static const MaterialColor appPrimaryMaterialColor = MaterialColor(
    _appPrimaryColorValue,
    <int, Color>{
      50: Color(0xFFb4e4bd),
      100: Color(0xFF7bd18c),
      200: Color(0xFF68ca7c),
      300: Color(0xFF55c36b),
      400: Color(0xFF42bd5b),
      500: Color(_appPrimaryColorValue),
      600: Color(0xFF359749),
      700: Color(0xFF2e8440),
      800: Color(0xFF287136),
      900: Color(0xFF215e2d),
    },
  );

  static const Color primaryButtonColor = Color(_appPrimaryColorValue);
  static const Color appErrorBackground = Color(0xFF91031A);
  static const Color primaryBackground = Colors.white;
  static const Color colorAccent = Color(0xFF666666);
  static const Color complementaryColor = Color(0xFFB840A0);
  static const Color lightGrey = Color(0xFFEEEEEE);
  static const Color darkGray = Color(0xFF444444);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textColorDark = Color(0xFF666666);
  static const Color textColorLight = Color(0xFFFFFFFF);
  static const Color iconColorDark = Color(0xFF666666);
  static const Color iconColorLight = Color(0xFFFFFFFF);
  static const Color lightGreenButtonColor = Color(0xFFa0afa0);
  static const Color orangeColor = Color(0xFFff7e04);
  static Color foregroundColorLight = const Color(0xFF40B858).withOpacity(0.64);
  static Color tableBgGreenDark = appPrimaryColor.withOpacity(0.16);
  static Color tableBgGreenLight = appPrimaryColor.withOpacity(0.08);
  // static const Color foregroundColorLight = Color(0xFF9CD09B);
  static Color backgroundOverlayWhite = Colors.white.withOpacity(0.9);
  static Color sliderInActiveColor = const Color(0xFF64B663).withOpacity(0.6);
  static const Color sliderActiveColor = Color(0xFF64B663);
  static Color lightBackground = appPrimaryColor.withOpacity(0.08);
  static const Color walletBgColorViolet = Color(0xFFB840A0);
  static const Color walletBgColorOrange = Color(0xFFEF8533);
  static const Color walletBgColorGreen = Color(0xFFC6D044);
  static const Color loadingColorLight = Color(0xFFDFF8DC);
}
