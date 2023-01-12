import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/core/widgets/app_padding.dart';
import 'package:automation_wrapper_builder/views/widgets/history_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/core/theme_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sidePanel = ref.watch(sidebarContentProvider);

    return Row(
      children: [
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            child: DefaultAppPadding(
              child: Column(
                children: const [
                  HistoryTable(),
                  verticalSpaceLarge,
                ],
              ),
            ),
          ),
        ),
        if (sidePanel != null)
          Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => ref
                          .watch(sidebarContentProvider.notifier)
                          .state = null,
                      icon: const Icon(Icons.close)),
                  sidePanel,
                ],
              )),
      ],
    );
  }
}
