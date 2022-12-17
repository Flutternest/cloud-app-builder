import 'package:automation_wrapper_builder/core/constants/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/selected_menu_controller.dart';
import '../../core/router/app_router.dart';
import '../../core/utils/ui_helper.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selectedMenu = ref.watch(selectedMenuProvider);
      return Drawer(
        child: Column(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme(context).colorScheme.inversePrimary,
              ),
              child: Center(
                  child: Image.asset(
                AppPaths.logo,
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
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   selected: selectedMenu == SidebarMenuItem.settings,
            //   title: const Text('Settings'),
            //   onTap: () {
            //     ref.read(selectedMenuProvider.notifier).state =
            //         SidebarMenuItem.settings;
            //   },
            // ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              iconColor: Colors.red,
              textColor: Colors.red,
              title: const Text('Logout'),
              onTap: () {
                AppRouter.navigateAndRemoveUntil(AppRoutes.loginPage);
              },
            ),
          ],
        ),
      );
    });
  }
}
