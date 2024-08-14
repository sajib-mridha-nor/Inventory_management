import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor mdhakalive =
      MaterialColor(_mdhakalivePrimaryValue, <int, Color>{
    50: Color(0xFFFDEBE6),
    100: Color(0xFFFBCDC0),
    200: Color(0xFFF8AC96),
    300: Color(0xFFF58A6B),
    400: Color(0xFFF3714C),
    500: Color(_mdhakalivePrimaryValue),
    600: Color(0xFFEF5027),
    700: Color(0xFFED4721),
    800: Color(0xFFEB3D1B),
    900: Color(0xFFE72D10),
  });
  static const int _mdhakalivePrimaryValue = 0xFFF1582C;
  static const Color backgroundColor = Color(0xFF1C1C1E);

  static const Color readmoreClr = Color(0xFFFFB49E);
  static const Color detailsClr = Color(0xFFE7BDB2);

  static const MaterialColor mdhakaliveAccent =
      MaterialColor(_mdhakaliveAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_mdhakaliveAccentValue),
    400: Color(0xFFFFB6AD),
    700: Color(0xFFFF9F94),
  });
  static const int _mdhakaliveAccentValue = 0xFFFFE4E0;

  // HexColor("#E7BDB2")

}
