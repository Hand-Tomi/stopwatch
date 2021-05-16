import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    final originalTheme = ThemeData.light();
    return originalTheme.copyWith(
      primaryColor: const Color(0xFFA64962),
      accentColor: const Color(0xFF1D2526),
      dividerColor: const Color(0xffCCCCCC),
    );
  }
}
