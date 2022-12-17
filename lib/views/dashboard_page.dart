import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/core/widgets/app_padding.dart';
import 'package:automation_wrapper_builder/core/widgets/hover_builder.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizeInfo) {
          return Row(
            children: [
              const Expanded(flex: 2, child: SideBar()),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: 50,
                    //   width: double.infinity,
                    //   color: theme(context).colorScheme.inversePrimary,
                    //   // color: Colors.grey,
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DefaultAppPadding(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: const [
                                  Expanded(child: InfoContainerRow()),
                                  AddNewButton(),
                                ],
                              ),
                              verticalSpaceMedium,
                              Text(
                                "Build History",
                                style:
                                    textTheme(context).titleSmall!.copyWith(),
                              ),
                              verticalSpaceRegular,
                              const BuildHistoryTable(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddNewButton extends StatelessWidget {
  const AddNewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverEffect(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width / 10,
          height: MediaQuery.of(context).size.width / 10,
          // padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: theme(context).colorScheme.primary,
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Icon(
                      Icons.add_circle,
                      size: 50,
                      color: theme(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Add New",
                  style: textTheme(context).titleSmall!.copyWith(
                        color: theme(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme(context).colorScheme.primary,
            ),
            child: const Center(child: Text('Logo')),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            selected: true,
            title: const Text('Dashboard'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            iconColor: Colors.red,
            textColor: Colors.red,
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class InfoContainerRow extends StatelessWidget {
  const InfoContainerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        InfoContainer(contentType: "Total Variants", value: "22"),
        horizontalSpaceRegular,
        InfoContainer(contentType: "Total Variants", value: "22"),
      ],
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer(
      {Key? key, required this.contentType, required this.value})
      : super(key: key);

  final String contentType;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 10,
      height: MediaQuery.of(context).size.width / 10,
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: theme(context).colorScheme.inversePrimary,
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  value,
                  style: textTheme(context).displaySmall!.copyWith(
                        color: theme(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              contentType,
              style: textTheme(context).titleSmall!.copyWith(
                    color: theme(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildHistoryTable extends StatelessWidget {
  const BuildHistoryTable({super.key});

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
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {},
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
