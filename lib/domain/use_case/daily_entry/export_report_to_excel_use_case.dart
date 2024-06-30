import 'dart:io';

import 'package:chss_noon_meal/core/extension/date_time_extension.dart';
import 'package:chss_noon_meal/domain/entity/config/class_data.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExportReportToExcelUseCase
    extends UseCase<String, ExportReportToExcelUseCaseParams> {
  @override
  Future<String> execute(ExportReportToExcelUseCaseParams params) async {
    final workbook = Workbook();
    final sheet = workbook.worksheets[0];
    sheet.getRangeByIndex(1, 1, 3, 1)
      ..merge()
      ..setText('Date')
      ..cellStyle.hAlign = HAlignType.center
      ..cellStyle.vAlign = VAlignType.center;

    // Center-align the "Date" header
    final dateHeaderCell = sheet.getRangeByIndex(1, 1);
    dateHeaderCell.cellStyle.hAlign = HAlignType.center;
    dateHeaderCell.cellStyle.vAlign = VAlignType.center;

    var currentColumnIndex = 2;
    for (var i = 0; i < params.classList.length; i++) {
      final divisionList = params.classList[i].divisions;
      final divisionsCount = divisionList.length;

      // Merge cells for the class name
      sheet.getRangeByIndex(
        1,
        currentColumnIndex,
        1,
        currentColumnIndex + (divisionsCount * 2) - 1,
      )
        ..merge()
        ..setText(params.classList[i].className)
        ..cellStyle.hAlign = HAlignType.center
        ..cellStyle.vAlign = VAlignType.center;

      for (var j = 0; j < divisionsCount; j++) {
        // Merge cells for the division name
        sheet.getRangeByIndex(2, currentColumnIndex, 2, currentColumnIndex + 1)
          ..merge()
          ..setText(divisionList[j])
          ..cellStyle.hAlign = HAlignType.center
          ..cellStyle.vAlign = VAlignType.center;

        // Write "Boys" in the third row and center-align
        sheet.getRangeByIndex(3, currentColumnIndex)
          ..setText('Boys')
          ..cellStyle.hAlign = HAlignType.center
          ..cellStyle.vAlign = VAlignType.center;

        // Write "Girls" in the third row, next column, and center-align
        sheet.getRangeByIndex(3, currentColumnIndex + 1)
          ..setText('Girls')
          ..cellStyle.hAlign = HAlignType.center
          ..cellStyle.vAlign = VAlignType.center;

        // Move to the next set of columns for the next division
        currentColumnIndex += 2;
      }
    }

// Loop from start date to end date
    var index = 0;
    for (var date = params.startDate;
        date.isBefore(params.endDate) || date.isAtSameMomentAs(params.endDate);
        date = date.add(const Duration(days: 1))) {
      sheet.getRangeByIndex(index + 4, 1)
        ..setText(date.toStringFormatted('dd-MM-yyyy'))
        ..cellStyle.hAlign = HAlignType.center
        ..cellStyle.vAlign = VAlignType.center;

      // Step 2: Populate values for boys and girls
      currentColumnIndex = 2;

      for (var i = 0; i < params.classList.length; i++) {
        final divisionList = params.classList[i].divisions;

        for (var j = 0; j < divisionList.length; j++) {
          final entry = params.dailyEntryList.firstWhereOrNull(
            (element) =>
                element.classId == params.classList[i].classId &&
                element.division == params.classList[i].divisions[j] &&
                isSameDay(element.date, date),
          );
          if (entry != null) {
            sheet.getRangeByIndex(index + 4, currentColumnIndex)
              ..setText(entry.boysCount > 0 ? entry.boysCount.toString() : '-')
              ..cellStyle.hAlign = HAlignType.center
              ..cellStyle.vAlign = VAlignType.center;

            sheet.getRangeByIndex(index + 4, currentColumnIndex + 1)
              ..setText(
                entry.girlsCount > 0 ? entry.girlsCount.toString() : '-',
              )
              ..cellStyle.hAlign = HAlignType.center
              ..cellStyle.vAlign = VAlignType.center;
          }
          currentColumnIndex += 2;
        }
      }

      index++;
    }

    final bytes = workbook.saveAsStream();

    // Save the Excel file
    final path = (await getApplicationDocumentsDirectory()).path;
    final fileName = '$path/chss_meals_report.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);

    // Open the Excel file
    await OpenFile.open(fileName);

    workbook.dispose();
    return 'File saved to $path';
  }

  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 != null && date2 != null) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }
    return false;
  }
}

class ExportReportToExcelUseCaseParams extends Equatable {
  const ExportReportToExcelUseCaseParams({
    required this.dailyEntryList,
    required this.classList,
    required this.startDate,
    required this.endDate,
  });

  final List<DailyEntry> dailyEntryList;
  final List<ClassData> classList;
  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [
        dailyEntryList,
        classList,
        startDate,
        endDate,
      ];
}
