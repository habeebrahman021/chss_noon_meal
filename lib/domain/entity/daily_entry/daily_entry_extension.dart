import 'package:chss_noon_meal/data/model/daily_entry/daily_entry_model.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';

extension DailyEntryModelExtension on DailyEntryModel {
  DailyEntry toDomain() {
    return DailyEntry(
      id: id ?? '',
      classId: classId ?? '',
      className: className ?? '',
      division: division ?? '',
      boysCount: boysCount ?? 0,
      girlsCount: girlsCount ?? 0,
    );
  }
}

extension DailyEntryModelListExtension on List<DailyEntryModel> {
  List<DailyEntry> toEntityList() {
    return map((e) => e.toDomain()).toList();
  }
}
