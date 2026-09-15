import 'package:flutter/material.dart';

class PelkoraTheme {
  static const Color botanicalGreen = Color(0xFF2E6F40);
  static const Color reservoirAqua = Color(0xFF00A896);
  static const Color terracotta = Color(0xFFE07A5F);
  static const Color creamBg = Color(0xFFF7F9F5);
  static const Color borderCard = Color(0xFFE2E8DE);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      scaffoldBackgroundColor: creamBg,
      colorScheme: const ColorScheme.light(
        primary: botanicalGreen,
        secondary: reservoirAqua,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: Color(0xFF1E2923),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: botanicalGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
