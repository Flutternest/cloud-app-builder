import 'dart:developer';

import 'package:automation_wrapper_builder/views/dashboard_page.dart';
import 'package:automation_wrapper_builder/views/login_page.dart';
import 'package:automation_wrapper_builder/views/menu_page.dart';
import 'package:flutter/material.dart';

import '../../views/add_app_page.dart';

class AppRoutes {
  static const loginPage = '/';
  static const menuPage = '/menu-page';
  static const dashboardPage = '/dashboard-page';
  static const addAppPage = '/add-app-page';
}

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Future<dynamic> navigateToPage(String routeName,
      {bool replace = false, dynamic arguments}) async {
    log("Navigation: $routeName | Type: Push | Replace: $replace | Args: $arguments");

    if (replace) {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }

  static void pop([dynamic result]) {
    log("Navigation | Type: Pop | Args: $result");
    navigatorKey.currentState!.pop(result);
  }

  static void maybePop([dynamic result]) {
    log("Navigation | Type: Maybe Pop | Args: $result");
    navigatorKey.currentState!.maybePop(result);
  }

  static void navigateAndRemoveUntil(String routeName, {dynamic arguments}) {
    log("Navigation | Type: Permanent Navigation | Args: No args");
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  static void popUntil(bool Function(Route<dynamic>) route) {
    log("Navigation | Type: Pop (Until) | Pop Route: $route");
    navigatorKey.currentState!.popUntil(route);
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginPage(),
          settings: settings,
          fullscreenDialog: false,
        );
      case AppRoutes.menuPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const MenuPage(),
          settings: settings,
          fullscreenDialog: false,
        );
      case AppRoutes.dashboardPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const DashboardPage(),
          settings: settings,
          fullscreenDialog: false,
        );
      case AppRoutes.addAppPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const AddAppPage(),
          settings: settings,
          fullscreenDialog: false,
        );

      default:
        return null;
    }
  }
}
