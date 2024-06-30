import 'package:chss_noon_meal/domain/entity/config/class_data.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class UpdateClassListWithDailyEntriesUseCase extends UseCase<List<DailyEntry>,
    UpdateClassListWithDailyEntriesUseCaseParams> {
  @override
  Future<List<DailyEntry>> execute(
    UpdateClassListWithDailyEntriesUseCaseParams params,
  ) async {
    final updatedList = <DailyEntry>[];

    // Loop from start date to end date
    for (var date = params.startDate;
        date.isBefore(params.endDate) || date.isAtSameMomentAs(params.endDate);
        date = date.add(const Duration(days: 1))) {
      for (final classData in params.classList) {
        for (final division in classData.divisions) {
          final entry = params.dailyEntries
              .where(
                (element) =>
                    element.classId == classData.classId &&
                    element.division == division &&
                    isSameDay(element.date, date),
              )
              .toList();
          if (entry.isNotEmpty) {
            updatedList.add(entry.first);
          } else {
            updatedList.add(
              DailyEntry(
                classId: classData.classId,
                date: date,
                division: division,
                className: classData.className,
                boysCount: 0,
                girlsCount: 0,
              ),
            );
          }
        }
      }
    }

    return updatedList;
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

class UpdateClassListWithDailyEntriesUseCaseParams extends Equatable {
  const UpdateClassListWithDailyEntriesUseCaseParams({
    required this.startDate,
    required this.endDate,
    required this.classList,
    required this.dailyEntries,
  });

  final DateTime startDate;
  final DateTime endDate;
  final List<ClassData> classList;
  final List<DailyEntry> dailyEntries;

  @override
  List<Object?> get props => [
        classList,
        dailyEntries,
      ];
}
