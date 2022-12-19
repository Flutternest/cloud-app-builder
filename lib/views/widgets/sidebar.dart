import 'package:automation_wrapper_builder/controllers/core/prefs_provider.dart';
import 'package:automation_wrapper_builder/controllers/core/theme_provider.dart';
import 'package:automation_wrapper_builder/core/constants/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/selected_menu_controller.dart';
import '../../core/router/app_router.dart';
import '../../core/utils/ui_helper.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMenu = ref.watch(selectedMenuProvider);
    final isDarkTheme = ref.watch(themeBrightnessProvider) == Brightness.dark;
    return Drawer(
      child: Column(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDarkTheme
                  ? theme(context).colorScheme.primaryContainer
                  : theme(context).colorScheme.inversePrimary,
            ),
            child: Center(
                child: Image.asset(
              isDarkTheme ? AppPaths.logoDark : AppPaths.logo,
              width: 200,
            )),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            selected: selectedMenu == SidebarMenuItem.dashboard,
            title: const Text('Dashboard'),
            onTap: () {
              ref.read(selectedMenuProvider.notifier).state =
                  SidebarMenuItem.dashboard;
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            selected: selectedMenu == SidebarMenuItem.addApp,
            title: const Text('Create App'),
            onTap: () {
              ref.read(selectedMenuProvider.notifier).state =
                  SidebarMenuItem.addApp;
            },
          ),
          const Spacer(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            onChanged: (bool value) async {
              ref.read(themeBrightnessProvider.notifier).state =
                  value ? Brightness.dark : Brightness.light;

              await ref.read(prefsProvider).setBool('isDarkMode', value);
            },
            value: ref.read(themeBrightnessProvider.notifier).state ==
                Brightness.dark,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            iconColor: Colors.red,
            textColor: Colors.red,
            title: const Text('Logout'),
            onTap: () async {
              await ref.read(prefsProvider).setBool('isLoggedIn', false);
              AppRouter.navigateAndRemoveUntil(AppRoutes.loginPage);
            },
          ),
        ],
      ),
    );
  }
}
