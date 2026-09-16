import 'package:flutter/material.dart';

class PelkoraTheme {
  static const bg = Color(0xFFF5FAF6);
  static const surface = Color(0xFFFFFFFF);
  static const edge = Color(0xFFD1E7D8);
  static const accent = Color(0xFF059669);
  static const accentLight = Color(0xFF34D399);
  static const ink = Color(0xFF064E3B);
  static const muted = Color(0xFF047857);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: bg,
      fontFamily: 'AppFont',
      primaryColor: accent,
      colorScheme: const ColorScheme.light(
        primary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: ink,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: surface,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: edge, width: 1.5),
        ),
      ),
    );
  }
}
