import 'dart:ui';

import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/core/widgets/app_padding.dart';
import 'package:automation_wrapper_builder/views/widgets/history_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../controllers/core/theme_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sidePanel = ref.watch(sidebarContentProvider);

    return ResponsiveBuilder(builder: (context, sizeInfo) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: DefaultAppPadding(
              child: Column(
                children: const [
                  HistoryTable(),
                  verticalSpaceLarge,
                ],
              ),
            ),
          ),
          if (sidePanel != null) ...[
            Container(
              width: double.infinity,
              height: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(color: Colors.black45),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: sizeInfo.isMobile || sizeInfo.isTablet
                    ? double.infinity
                    : MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    offset: Offset(-5, -5),
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 5,
                  )
                ]),
                child: Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => ref
                              .watch(sidebarContentProvider.notifier)
                              .state = null,
                          icon: const Icon(Icons.close)),
                      Expanded(child: sidePanel),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      );
    });
  }
}
