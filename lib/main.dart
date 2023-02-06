import 'package:automation_wrapper_builder/controllers/core/prefs_provider.dart';
import 'package:automation_wrapper_builder/core/theme/app_theme.dart';
import 'package:automation_wrapper_builder/views/login_page.dart';
import 'package:automation_wrapper_builder/views/menu_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/core/theme_provider.dart';
import 'core/router/app_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      overrides: [prefsProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeBrightnessProvider) == Brightness.dark
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automation Wrapper App Builder',
      theme: theme,
      onGenerateRoute: (settings) {
        final isLoggedIn =
            ref.read(prefsProvider).getBool('isLoggedIn') ?? false;
        if (settings.name != AppRoutes.loginPage && !isLoggedIn) {
          return null;
        }
        return AppRouter.onGenerateRoute(settings);
      },
      navigatorKey: AppRouter.navigatorKey,
    );
  }
}
