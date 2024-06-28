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
    for (final classData in params.classList) {
      for (final division in classData.divisions) {
        final entry = params.dailyEntries
            .where(
              (element) =>
                  element.classId == classData.classId &&
                  element.division == division,
            )
            .toList();
        if (entry.isNotEmpty) {
          updatedList.add(entry.first);
        } else {
          updatedList.add(
            DailyEntry(
              classId: classData.classId,
              division: division,
              className: classData.className,
              boysCount: 0,
              girlsCount: 0,
            ),
          );
        }
      }
    }
    return updatedList;
  }
}

class UpdateClassListWithDailyEntriesUseCaseParams extends Equatable {
  const UpdateClassListWithDailyEntriesUseCaseParams({
    required this.classList,
    required this.dailyEntries,
  });

  final List<ClassData> classList;
  final List<DailyEntry> dailyEntries;

  @override
  List<Object?> get props => [
        classList,
        dailyEntries,
      ];
}
