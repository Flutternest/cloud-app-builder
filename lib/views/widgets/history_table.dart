import 'package:automation_wrapper_builder/views/add_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/core/theme_provider.dart';

class HistoryTable extends ConsumerWidget {
  const HistoryTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginatedDataTable(
      header: const Text("Build History"),
      // onRowsPerPageChanged: (perPage) {},
      rowsPerPage: 15,
      availableRowsPerPage: const [5, 10, 15, 20, 25, 30],
      columns: <DataColumn>[
        DataColumn(
          label: const Text('Name'),
          onSort: (columnIndex, ascending) {},
        ),
        const DataColumn(
          label: Text('Bundle ID'),
        ),
        const DataColumn(
          label: Text('Website URL'),
        ),
        const DataColumn(
          label: Text('Version Code'),
        ),
        const DataColumn(
          label: Text('Version#'),
        ),
        const DataColumn(
          label: Text('Created on'),
        ),
        const DataColumn(
          label: Text('Updated on'),
        ),
        const DataColumn(
          label: Text('Actions'),
        ),
      ],
      source: HistoryDataTableSource(
        onEditTap: () {
          ref.watch(sidebarContentProvider.notifier).state = AddAppPage(
            isUpdate: true,
            appPackage: AppPackage(
              bundleId: "bet.predict.1.app",
              color: "000000",
              iconUrl: "https://www.facebook.com/images/fb_icon_325x325.png",
              name: "Bet Predictions 1",
              versionCode: "1.0.0",
              versionNumber: "12",
              websiteUrl: "https://predictions.web.app/1.html",
              toEmail: "admin@awabuilder.com",
            ),
          );
        },
        onDeleteTap: () {},
        onDownloadTap: () {},
      ),
    );
  }
}

class HistoryDataTableSource extends DataTableSource {
  final VoidCallback onEditTap;
  final VoidCallback onDownloadTap;
  final VoidCallback onDeleteTap;

  HistoryDataTableSource({
    required this.onEditTap,
    required this.onDownloadTap,
    required this.onDeleteTap,
  });

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("Bet Predictions $index")),
        DataCell(Text("bet.predict.$index.app")),
        DataCell(Text("https://predictions.web.app/$index.html")),
        const DataCell(Text("1.0.0")),
        const DataCell(Text("12")),
        const DataCell(Text("12 Jan 2021")),
        const DataCell(Text("14 Jan 2021")),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                iconSize: 20,
                onPressed: onEditTap,
              ),
              IconButton(
                icon: const Icon(Icons.download),
                iconSize: 20,
                onPressed: onEditTap,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                iconSize: 20,
                onPressed: onDeleteTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}
