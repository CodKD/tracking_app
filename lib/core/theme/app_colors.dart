import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color grey = Color(0xff535353);
  static const Color red = Color(0xffCC1010);
  static const Color green = Color(0xff0CB359);
  static const Color lightPink = Color(0xffF9ECF0);
  static const Color transparent = Colors.transparent;
  static const MaterialColor white = MaterialColor(
    0xFFF9F9F9, // BASE
    <int, Color>{
      50: Color(0xFFFEFEFE), // 10%
      100: Color(0xFFFDFDFD), // 20%
      200: Color(0xFFFCFCFC), // 30%
      300: Color(0xFFFBFBFB), // 40%
      400: Color(0xFFFAFAFA), // 50%
      500: Color(0xFFF9F9F9), // BASE
      600: Color(0xFFD0D0D0), // 60%
      700: Color(0xFFA6A6A6), // 70%
      800: Color(0xFF7D7D7D), // 80%
      900: Color(0xFF535353), // 90%
      950: Color(0xFF323232), // 100% (extra)
    },
  );

  static const MaterialColor pink = MaterialColor(
    0xFFD21E6A, // BASE
    <int, Color>{
      50: Color(0xFFF6D2E1), // 10%
      100: Color(0xFFF0B4CD), // 20%
      200: Color(0xFFE98FB5), // 30%
      300: Color(0xFFE1699C), // 40%
      400: Color(0xFFDA4483), // 50%
      500: Color(0xFFD21E6A), // BASE
      600: Color(0xFFAF1958), // 60%
      700: Color(0xFF8C1447), // 70%
      800: Color(0xFF690F35), // 80%
      900: Color(0xFF460A23), // 90%
      950: Color(0xFF2A0615), // 100% (extra)
    },
  );

  static const MaterialColor black = MaterialColor(
    0xFF0C1015, // BASE
    <int, Color>{
      50: Color(0xFFCECFD0), // 10%
      100: Color(0xFFAEAFB1), // 20%
      200: Color(0xFF86888A), // 30%
      300: Color(0xFF5D6063), // 40%
      400: Color(0xFF34383C), // 50%
      500: Color(0xFF0C1015), // BASE
      600: Color(0xFF0A0D12), // 60%
      700: Color(0xFF08080E), // 70%
      800: Color(0xFF06080B), // 80%
      900: Color(0xFF040507), // 90%
      950: Color(0xFF020304), // 100% (extra)
    },
  );
}
