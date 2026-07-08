import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color foreground = Color(0xFF000000);
  static const Color muted = Color(0xFF8C8C8C);
  static const Color border = Color(0xFFDBDBDB);
  static const Color accent = Color(0xFF000000);
  static const Color accentSecondary = Color(0xFF0057FF); // #0057ff
  
  static const Color textBlack = Color(0xFF000000);
  static const Color textGrey = Color(0xFF8C8C8C);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: accentSecondary,
        secondary: accent,
        surface: surface,
        onSurface: foreground,
      ),
    );
  }
}
