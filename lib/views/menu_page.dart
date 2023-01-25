import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/views/add_app_page.dart';
import 'package:automation_wrapper_builder/views/dashboard_page.dart';
import 'package:automation_wrapper_builder/views/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../controllers/selected_menu_controller.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeInfo) {
        return Scaffold(
          appBar: sizeInfo.isMobile
              ? AppBar(
                  title: const Text("AWA Builder"),
                  centerTitle: true,
                  backgroundColor: theme(context).scaffoldBackgroundColor,
                )
              : null,
          drawer:
              sizeInfo.isMobile ? const SideBar(shouldCloseDrawer: true) : null,
          floatingActionButton: Consumer(builder: (context, ref, child) {
            if (ref.watch(selectedMenuProvider) == SidebarMenuItem.dashboard) {
              return FloatingActionButton.extended(
                label: const Text("Add New"),
                onPressed: () {
                  ref.read(selectedMenuProvider.notifier).state =
                      SidebarMenuItem.addApp;
                },
                icon: const Icon(Icons.add_circle),
              );
            }
            return const SizedBox.shrink();
          }),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!sizeInfo.isMobile) Expanded(flex: 2, child: buildSidebar()),
              Consumer(builder: (context, ref, child) {
                return Expanded(
                  flex: 8,
                  child: buildPageStack(ref),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  SideBar buildSidebar() => const SideBar();

  IndexedStack buildPageStack(WidgetRef ref) {
    return IndexedStack(
      index: ref.watch(selectedMenuProvider),
      children: const [
        DashboardPage(),
        AddAppPage(),
        AddAppPage(),
      ],
    );
  }
}
