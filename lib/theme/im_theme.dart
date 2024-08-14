import 'package:flutter/material.dart';

import 'color_schemes.g.dart';
 

 

class IMTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      colorScheme: darkColorScheme,
      useMaterial3: false,
      fontFamily: 'Nunito',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        // color: Colors.transparent
      ),
    );
  }

  static ThemeData lightTheme() {
    
    return ThemeData(
      colorScheme: lightColorScheme,
      useMaterial3: true,
      fontFamily: 'Nunito',
      appBarTheme: AppBarTheme(
        shadowColor: Colors.black26,
        elevation: 10
      ),
    );
  }
}
