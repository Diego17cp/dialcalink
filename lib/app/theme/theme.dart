import 'package:flutter/material.dart';
import 'package:notidialca/app/theme/color_schemes.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );
  static ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
  );
}
