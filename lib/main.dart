import 'package:automation_wrapper_builder/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automation Wrapper App Builder',
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      navigatorKey: AppRouter.navigatorKey,
    );
  }
}
