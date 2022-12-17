import 'package:automation_wrapper_builder/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
    ),
    colorScheme: lightColorScheme,
  );
  static final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    colorScheme: lightColorScheme,
  );
}
