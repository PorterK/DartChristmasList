import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const int _greenPrimary = 0xFF4CAF50;

  static const MaterialColor primary = MaterialColor(
    _greenPrimary,
    <int, Color>{
       50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5d6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB69),
      500: Color(_greenPrimary),
      600: Color(0xFF43A046),
      700: Color(0xFF388E3B),
      800: Color(0xFF2E7d31),
      900: Color(0xFF1B5E1F)
    }
  );

  static const int _redPrimary = 0xFFD32F2F;

  static const MaterialColor secondary = MaterialColor(
    _redPrimary,
    <int, Color>{
       50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(_redPrimary),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71B1C)
    }
  );
}