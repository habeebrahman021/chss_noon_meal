import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../core/di/injector.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/model/daily_entry/daily_entry_model.dart';
import '../../../domain/entity/daily_entry/daily_entry.dart';
import '../bloc/reports_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class EntryReport extends StatefulWidget {
  const EntryReport({super.key});
  static const String route = '/entry';
  @override
  State<EntryReport> createState() => EntryReportState();
}

class EntryReportState extends State<EntryReport> {
  late EntryDataSource entryDataSource;

  List<DailyEntryModel> entries = <DailyEntryModel>[];

  @override
  void initState() {
    super.initState();
    entries = getEntry();
    entryDataSource = EntryDataSource(entries: entries);
  }

  List<DailyEntryModel> getEntry() {
    return[
      DailyEntryModel(date: "29-06-2024",className:"8",division: "A",boysCount: 22,girlsCount: 15),
      DailyEntryModel(date: "28-06-2024",className:"8",division: "A",boysCount: 22,girlsCount: 15),
      DailyEntryModel(date: "27-06-2024",className:"8",division: "A",boysCount: 22,girlsCount: 15),
      DailyEntryModel(date: "26-06-2024",className:"8",division: "A",boysCount: 22,girlsCount: 15),
    ];
    /*return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];*/
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ReportsBloc>(),
      child: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar:  AppBar(
              backgroundColor: AppColors.app_color,
              elevation: 0,
              iconTheme: IconThemeData(
                color:AppColors.white, // Change this to your desired color
              ),
              title: const Text(
                'Report',
                style: TextStyle(color: AppColors.white,fontSize: 20),
              ),
              /* actions: [
           IconButton(
             icon: const Icon(
               Icons.arrow_back,
               color: AppColors.black,
             ),
             onPressed: () => GoRouter.of(context)
                 .pop(), // Go back using GoRouter
           ),
         ],*/
            ),
            body: BlocListener<ReportsBloc, ReportsState>(
              listener: (context, state) {
                if (state.status.isSuccess) {
                  GoRouter.of(context).pop();
                }
              },
              child: BlocBuilder<ReportsBloc, ReportsState>(
                builder: (context, state) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15,top: 30),
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(headerColor: AppColors.commitmentstatusbg),
                        child: SfDataGrid(
                          source: entryDataSource,
                          columnWidthMode: ColumnWidthMode.fill,
                         // columnWidthCalculationRange: ColumnWidthCalculationRange.visibleRows,
                          columns: [
                            GridColumn(
                                columnName: 'date',
                                label: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Date',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'class',
                                label: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Class',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'division',
                                label: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Division',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'boys',
                                label: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Boys',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'girls',
                                label: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Girls',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                          ],
                            gridLinesVisibility: GridLinesVisibility.both,
                            headerGridLinesVisibility: GridLinesVisibility.both
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
class EntryDataSource extends DataGridSource {
  EntryDataSource({required List<DailyEntryModel> entries}) {
    dataGridRows = entries
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'date', value: dataGridRow.date),
      DataGridCell<String>(columnName: 'class', value: dataGridRow.className),
      DataGridCell<String>(
          columnName: 'division', value: dataGridRow.division),
      DataGridCell<int>(
          columnName: 'boys', value: dataGridRow.boysCount),
      DataGridCell<int>(
          columnName: 'girls', value: dataGridRow.girlsCount),
    ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment : Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ));
        }).toList());
  }
}
