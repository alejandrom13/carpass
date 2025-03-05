import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var labelColor = const Color.fromARGB(255, 0, 0, 0);
var _bgColor = const Color(0xFFF1F4F9);
var _primaryColor = const Color.fromARGB(255, 0, 0, 0);
var _secondaryColor = const Color.fromARGB(255, 11, 21, 33);
var _tertiaryColor = const Color.fromRGBO(63, 183, 125, 1);

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      cardColor: const Color.fromARGB(255, 248, 248, 248),
      disabledColor: const Color.fromARGB(255, 181, 181, 182),
      shadowColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
      splashColor: Colors.transparent,
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        displayMedium: GoogleFonts.dmSans(
            fontSize: 20.0, fontWeight: FontWeight.w600, color: labelColor),
        displaySmall:
            GoogleFonts.dmSans(fontSize: 18.0, fontWeight: FontWeight.w600),
        titleLarge:
            GoogleFonts.dmSans(fontSize: 16.0, fontWeight: FontWeight.w600),
        titleMedium:
            GoogleFonts.dmSans(fontSize: 12.0, fontWeight: FontWeight.w500),
        titleSmall:
            GoogleFonts.dmSans(fontSize: 14.0, fontWeight: FontWeight.w600),
        bodyMedium:
            GoogleFonts.dmSans(fontSize: 12.0, fontWeight: FontWeight.bold),
        labelLarge:
            GoogleFonts.dmSans(fontSize: 15.0, fontWeight: FontWeight.w600),
        labelMedium:
            GoogleFonts.dmSans(fontSize: 15.0, fontWeight: FontWeight.w500),
      ),
      colorScheme: ColorScheme.light(
          surface: _bgColor,
          primary: _primaryColor,
          outline: const Color.fromRGBO(232, 232, 232, 1),
          onPrimary: Colors.white,
          tertiary: _tertiaryColor,
          secondary: _secondaryColor,
          error: const Color.fromARGB(255, 250, 100, 90),
          shadow: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
          primaryContainer: const Color.fromRGBO(189, 189, 189, 1),
          onPrimaryContainer: Color.fromRGBO(70, 68, 61, 1)),
    );
  }
}

var theme = CustomTheme.lightTheme;
var textTheme = CustomTheme.lightTheme.textTheme;
