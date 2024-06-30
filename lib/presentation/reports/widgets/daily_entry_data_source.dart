import 'package:chss_noon_meal/core/extension/date_time_extension.dart';
import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DailyEntryDataGridDataSource extends DataGridSource {
  DailyEntryDataGridDataSource({
    required List<DailyEntry> dailyEntries,
    required int userRole,
  }) {
    _dailyEntries = dailyEntries
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              if (userRole == 1 || userRole == 2) ...[
                DataGridCell<String>(
                  columnName: 'date',
                  value: e.date?.toStringFormatted('dd-MM-yyyy') ?? '-',
                ),
              ],
              DataGridCell<String>(columnName: 'class', value: e.className),
              DataGridCell<String>(columnName: 'division', value: e.division),
              DataGridCell<int>(columnName: 'boys_count', value: e.boysCount),
              DataGridCell<int>(columnName: 'girls_count', value: e.girlsCount),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _dailyEntries = [];

  @override
  List<DataGridRow> get rows => _dailyEntries;

  @override
  Widget? buildTableSummaryCellWidget(
    GridTableSummaryRow summaryRow,
    GridSummaryColumn? summaryColumn,
    RowColumnIndex rowColumnIndex,
    String summaryValue,
  ) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        summaryValue,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      final index = effectiveRows.indexOf(row);
      if (index.isEven) {
        return AppColors.white;
      } else {
        return AppColors.keyboard_BG;
      }
    }

    return DataGridRowAdapter(
      color: getBackgroundColor(),
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            dataGridCell.value.toString(),
            style: TextStyle(
              color: dataGridCell.value == 0 ? Colors.red : AppColors.black,
            ),
          ),
        );
      }).toList(),
    );
  }
}
