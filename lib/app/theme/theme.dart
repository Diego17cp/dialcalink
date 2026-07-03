import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dialcalink/app/theme/color_schemes.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: GoogleFonts.onestTextTheme(ThemeData.light().textTheme),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: GoogleFonts.onestTextTheme(ThemeData.dark().textTheme),
  );
}