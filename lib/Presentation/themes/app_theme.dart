import 'package:flutter/material.dart';

const stcPurple = Color(0xFF4F008C);
const stcCoral = Color(0xFFFF375E);
const stcOnyx = Color(0xFF1D252D);

class AppThemes {
  static ThemeData get defaultTheme {
    return ThemeData(
      scaffoldBackgroundColor: stcOnyx,
      primaryColor: stcPurple,
      fontFamily: 'Cairo',
      fontFamilyFallback: const ['Poppins'],
      colorScheme: const ColorScheme.dark(
        primary: stcPurple,
        secondary: stcCoral,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: stcPurple,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontFamilyFallback: ['Poppins'],
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  static ThemeData get ramadanTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F0E6),
      primaryColor: const Color(0xFF6A4C2A),
      fontFamily: 'Cairo',
      fontFamilyFallback: const ['Poppins'],
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF6A4C2A),
        secondary: Color(0xFFD4AF37),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF4E342E),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontFamilyFallback: ['Poppins'],
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.black),
      ),
    );
  }
}
