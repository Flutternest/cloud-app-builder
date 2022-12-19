import 'package:flutter/material.dart';

class HistoryTable extends StatelessWidget {
  const HistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      // header: const Text("Pagination Example"),
      onRowsPerPageChanged: (perPage) {},
      rowsPerPage: 10,
      availableRowsPerPage: const [5, 10, 20, 30],

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
          label: Text('Actions'),
        ),
      ],
      source: HistoryDataTableSource(),
    );
  }
}

class HistoryDataTableSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("Bet Predictions $index")),
      DataCell(Text("bet.predict.$index.app")),
      DataCell(Text("https://predictions.web.app/$index.html")),
      DataCell(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.download),
              iconSize: 20,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              iconSize: 20,
              onPressed: () {},
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}
