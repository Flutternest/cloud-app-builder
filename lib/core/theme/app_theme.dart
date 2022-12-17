import 'package:automation_wrapper_builder/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
  );
  static final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    colorScheme: lightColorScheme,
  );
}
