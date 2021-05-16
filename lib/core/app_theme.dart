import 'package:flutter/material.dart';

class AppTheme {
  static final _headline1 = TextStyle(
    fontSize: 70,
    fontWeight: FontWeight.normal,
    color: const Color(0xFF1D2526),
  );

  static ThemeData get theme {
    final originalTheme = ThemeData.light();
    return originalTheme.copyWith(
      primaryColor: const Color(0xFFA64962),
      accentColor: const Color(0xFF1D2526),
      dividerColor: const Color(0xffCCCCCC),
      textTheme: originalTheme.textTheme.copyWith(
        headline1: _headline1,
      ),
    );
  }
}
