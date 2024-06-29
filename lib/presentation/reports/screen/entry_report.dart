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

class EntryReport extends StatefulWidget {
  const EntryReport({super.key});

  static const String route = '/entry';

  @override
  State<EntryReport> createState() => EntryReportState();
}

class EntryReportState extends State<EntryReport> {
  late DailyEntryDataGridDataSource dailyEntryDataSource;

  List<DailyEntry> entries = <DailyEntry>[];

  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
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
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
        ),
        body: BlocListener<ReportsBloc, ReportsState>(
          listener: (context, state) {},
          child: BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              if (_dateController.text != state.formattedDate) {
                _dateController.text = state.formattedDate;
              }
              entries = state.dailyEntryList;
              dailyEntryDataSource = DailyEntryDataGridDataSource(
                dailyEntries: entries,
              );

              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(24),
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
                                  .add(DateSelected(date: value!));
                            }
                          });

                          // _showDatePicker;
                        },
                      ),
                    ),
                    const Gap(24),
                    Expanded(
                      child: state.status.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SfDataGridTheme(
                              data: SfDataGridThemeData(
                                gridLineColor: AppColors.grey150,
                                // headerColor: AppColors.app_color,
                              ),
                              child: SfDataGrid(
                                headerRowHeight: 45,
                                rowHeight: 45,
                                source: dailyEntryDataSource,
                                columnWidthMode: ColumnWidthMode.fill,
                                columns: [
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
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
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

  Future<void> _showDatePicker() async {
    final bloc = context.read<ReportsBloc>();
  }
}
