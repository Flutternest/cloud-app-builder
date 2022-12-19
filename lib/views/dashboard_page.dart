import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/core/widgets/app_padding.dart';
import 'package:automation_wrapper_builder/views/widgets/add_new_button.dart';
import 'package:automation_wrapper_builder/views/widgets/history_table.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultAppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: AddNewButton(),
            ),
            verticalSpaceMedium,
            Text(
              "Build History",
              style: textTheme(context).titleSmall!.copyWith(),
            ),
            verticalSpaceRegular,
            const HistoryTable(),
          ],
        ),
      ),
    );
  }
}
