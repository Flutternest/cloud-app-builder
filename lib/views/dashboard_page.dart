import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/core/widgets/app_padding.dart';
import 'package:automation_wrapper_builder/views/widgets/history_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/selected_menu_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton.extended(
          label: const Text("Add New"),
          onPressed: () {
            ref.read(selectedMenuProvider.notifier).state =
                SidebarMenuItem.addApp;
          },
          icon: const Icon(Icons.add_circle),
        );
      }),
      body: SingleChildScrollView(
        child: DefaultAppPadding(
          child: Column(
            children: const [
              HistoryTable(),
              verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }
}
