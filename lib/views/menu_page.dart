import 'package:automation_wrapper_builder/views/add_app_page.dart';
import 'package:automation_wrapper_builder/views/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../controllers/selected_menu_controller.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizeInfo) {
          return Row(
            children: [
              const Expanded(flex: 2, child: SideBar()),
              Consumer(builder: (context, ref, child) {
                return Expanded(
                  flex: 8,
                  child: IndexedStack(
                    index: ref.watch(selectedMenuProvider),
                    children: const [
                      DashboardPage(),
                      AddAppPage(),
                      AddAppPage(),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
