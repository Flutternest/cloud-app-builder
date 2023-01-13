import 'package:automation_wrapper_builder/controllers/core/theme_provider.dart';
import 'package:automation_wrapper_builder/core/router/app_router.dart';
import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/data/models/build_item.dart';
import 'package:automation_wrapper_builder/extensions/string_extension.dart';
import 'package:automation_wrapper_builder/views/add_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
          columns: const <DataColumn>[
            // DataColumn(
            //   label: Text('Status'),
            // ),
            DataColumn(
              label: Text('Name'),
            ),
            DataColumn(
              label: Text('Bundle ID'),
            ),
            DataColumn(
              label: Text('Website URL'),
            ),
            DataColumn(
              label: Text('Version Code'),
            ),
            DataColumn(
              label: Text('Version#'),
            ),
            DataColumn(
              label: Text('Created on'),
            ),
            DataColumn(
              label: Text('Updated on'),
            ),
            DataColumn(
              label: Text('Actions'),
            ),
          ],
          source: HistoryDataTableSource(
            finalList: history,
            onEditTap: (buildItem) {
              ref.watch(sidebarContentProvider.notifier).state = AddAppPage(
                buildItem: buildItem,
                isUpdate: true,
              );
            },
            onDeleteTap: (buildItem) {},
            onDownloadTap: (buildItem) {},
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

typedef BuildItemCallback = void Function(BuildItem buildItem);

class HistoryDataTableSource extends DataTableSource {
  final List<BuildItem> finalList;
  final BuildItemCallback onEditTap;
  final BuildItemCallback onDownloadTap;
  final BuildItemCallback onDeleteTap;

  HistoryDataTableSource({
    required this.finalList,
    required this.onEditTap,
    required this.onDownloadTap,
    required this.onDeleteTap,
  });

  @override
  DataRow? getRow(int index) {
    final item = finalList[index];
    final inProgress = item.status == "IN_PROGRESS";

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (inProgress) ...[
              const SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              horizontalSpaceRegular,
            ],
            Text(item.applicationName.validate),
          ],
        )),
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
                onPressed: inProgress ? null : () => onEditTap.call(item),
              ),
              IconButton(
                icon: const Icon(Icons.download),
                iconSize: 20,
                onPressed: inProgress ? null : () => onDownloadTap.call(item),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                iconSize: 20,
                onPressed: inProgress ? null : () => onDeleteTap.call(item),
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
