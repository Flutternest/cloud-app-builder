import 'package:automation_wrapper_builder/controllers/core/prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeBrightnessProvider = StateProvider<Brightness>((ref) {
  return ref.watch(prefsProvider).getBool('isDarkMode') ?? false
      ? Brightness.dark
      : Brightness.light;
});
