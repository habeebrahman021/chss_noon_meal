import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/presentation/reports/bloc/reports_bloc.dart';
import 'package:chss_noon_meal/presentation/reports/widgets/daily_entry_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  static const String route = '/report-screen';

  @override
  State<ReportScreen> createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  late DailyEntryDataGridDataSource dailyEntryDataSource;

  List<DailyEntry> entries = <DailyEntry>[];

  late TextEditingController _dateController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ReportsBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.app_color,
          title: const Text('Report'),
          actions: [
            BlocBuilder<ReportsBloc, ReportsState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.userRole == 1 || state.userRole == 2,
                  child: IconButton(
                    onPressed: () {
                      context.read<ReportsBloc>().add(ExportButtonPressed());
                    },
                    icon: const Icon(Icons.save),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocListener<ReportsBloc, ReportsState>(
          listener: (context, state) {},
          child: BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              if (_dateController.text != state.formattedDate) {
                _dateController.text = state.formattedDate;
              }

              if (_startDateController.text != state.formattedStartDate) {
                _startDateController.text = state.formattedStartDate;
              }

              if (_endDateController.text != state.formattedEndDate) {
                _endDateController.text = state.formattedEndDate;
              }
              entries = state.dailyEntryList;
              dailyEntryDataSource = DailyEntryDataGridDataSource(
                dailyEntries: entries,
                userRole: state.userRole,
              );

              final isAdmin = state.userRole == 1 || state.userRole == 2;
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isAdmin) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Start Date *',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  TextFormField(
                                    controller: _startDateController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      hintText: 'Date',
                                      suffixIcon: Icon(
                                        Icons.calendar_month,
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.textColor,
                                        ), // Default bottom border
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.textColor,
                                        ), // Bottom border when enabled
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.textColor,
                                        ), // Bottom border when focused
                                      ),
                                    ),
                                    onTap: () async {
                                      await showDatePicker(
                                        context: context,
                                        initialDate: state.startDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2025),
                                      ).then((value) {
                                        if (value != null) {
                                          context.read<ReportsBloc>().add(
                                                StartDateSelected(date: value),
                                              );
                                        }
                                      });

                                      // _showDatePicker;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'End Date *',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  TextFormField(
                                    controller: _endDateController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      hintText: 'Date',
                                      suffixIcon: Icon(
                                        Icons.calendar_month,
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.textColor,
                                        ), // Default bottom border
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.textColor,
                                        ), // Bottom border when enabled
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.textColor,
                                        ), // Bottom border when focused
                                      ),
                                    ),
                                    onTap: () async {
                                      await showDatePicker(
                                        context: context,
                                        initialDate: state.endDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2025),
                                      ).then((value) {
                                        if (value != null) {
                                          context.read<ReportsBloc>().add(
                                                EndDateSelected(date: value),
                                              );
                                        }
                                      });

                                      // _showDatePicker;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      const Gap(20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Date *',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: 'Date',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textColor,
                              ), // Default bottom border
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textColor,
                              ), // Bottom border when enabled
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textColor,
                              ), // Bottom border when focused
                            ),
                          ),
                          onTap: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: state.date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            ).then((value) {
                              if (value != null) {
                                context
                                    .read<ReportsBloc>()
                                    .add(DateSelected(date: value));
                              }
                            });

                            // _showDatePicker;
                          },
                        ),
                      ),
                      const Gap(20),
                    ],
                    Expanded(
                      child: state.status.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SfDataGridTheme(
                                data: SfDataGridThemeData(
                                  gridLineColor: AppColors.grey150,
                                   headerColor: AppColors.backgroundColor,
                                ),
                                child: SfDataGrid(
                                  headerRowHeight: 45,
                                  rowHeight: 45,
                                  source: dailyEntryDataSource,
                                  columnWidthMode: isAdmin
                                      ? ColumnWidthMode.auto
                                      : ColumnWidthMode.fill,
                                  columns: [
                                    if (state.userRole == 1 ||
                                        state.userRole == 2) ...[
                                      GridColumn(
                                        columnName: 'date',
                                        label: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            'Date',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                    GridColumn(
                                      columnName: 'class',
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          'Class',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                              color: AppColors.white
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'division',
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          'Division',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                              color: AppColors.white
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'boys_count',
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          'Boys',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                              color: AppColors.white
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'girls_count',
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          'Girls',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                              color: AppColors.white
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                  tableSummaryRows: [
                                    GridTableSummaryRow(
                                      position:
                                          GridTableSummaryRowPosition.bottom,
                                      showSummaryInRow: false,
                                      columns: [
                                        const GridSummaryColumn(
                                          name: 'Boys',
                                          columnName: 'boys_count',
                                          summaryType: GridSummaryType.sum,
                                        ),
                                        const GridSummaryColumn(
                                          name: 'Girls',
                                          columnName: 'girls_count',
                                          summaryType: GridSummaryType.sum,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
