import 'package:automation_wrapper_builder/data/models/build_item.dart';
import 'package:automation_wrapper_builder/extensions/string_extension.dart';
import 'package:automation_wrapper_builder/views/add_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../controllers/core/theme_provider.dart';
import '../../controllers/history_list_controller.dart';

class HistoryTable extends ConsumerWidget {
  const HistoryTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyListAsync = ref.watch(historyListProvider);

    return historyListAsync.when(
      data: (data) {
        final history = data.toList();
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
            finalList: history,
            onEditTap: () {
              ref.watch(sidebarContentProvider.notifier).state = AddAppPage(
                isUpdate: true,
                appPackage: AppPackage(
                  bundleId: "bet.predict.1.app",
                  color: "000000",
                  iconUrl:
                      "https://www.facebook.com/images/fb_icon_325x325.png",
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
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something went wrong"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class HistoryDataTableSource extends DataTableSource {
  final List<BuildItem> finalList;
  final VoidCallback onEditTap;
  final VoidCallback onDownloadTap;
  final VoidCallback onDeleteTap;

  HistoryDataTableSource({
    required this.finalList,
    required this.onEditTap,
    required this.onDownloadTap,
    required this.onDeleteTap,
  });

  @override
  DataRow? getRow(int index) {
    final item = finalList[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(item.applicationName.validate)),
        DataCell(Text(item.bundleId.validate)),
        DataCell(Text(item.websiteUrl.validate)),
        DataCell(Text(item.version.validate)),
        DataCell(Text(item.versionNumber.validate)),
        DataCell(Text(DateFormat.yMd().add_jm().format(item.createdAt!))),
        DataCell(Text(DateFormat.yMd().add_jm().format(item.updatedAt!))),
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
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => finalList.length;

  @override
  int get selectedRowCount => 0;
}
