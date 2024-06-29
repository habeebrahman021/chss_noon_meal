import 'package:chss_noon_meal/core/exceptions.dart';
import 'package:chss_noon_meal/core/extension/date_time_extension.dart';
import 'package:chss_noon_meal/data/data_source/remote/daily_entry_data_source.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry_extension.dart';

abstract class DailyEntryRepository {
  Future<List<DailyEntry>> getDailyEntriesByDate({
    required DateTime date,
    required String organizationId,
  });

  Future<List<DailyEntry>> getDailyEntriesByDateRange({
    required DateTime fromDate,
    required DateTime toDate,
    required String organizationId,
  });

  Future<String> saveDailyEntries({
    required DateTime date,
    required int boysCount,
    required int girlsCount,
    required String classId,
    required String className,
    required String division,
    required String organizationId,
  });

  Future<DailyEntry> getDailyEntryByDateAndClass({
    required DateTime date,
    required String classId,
    required String division,
    required String organizationId,
  });

  Future<String> updateDailyEntries({
    required String id,
    required int boysCount,
    required int girlsCount,
  });
}

class DefaultDailyEntryRepository implements DailyEntryRepository {
  DefaultDailyEntryRepository({required this.dataSource});

  final DailyEntryDataSource dataSource;

  @override
  Future<List<DailyEntry>> getDailyEntriesByDate({
    required DateTime date,
    required String organizationId,
  }) async {
    final result = await dataSource.getDailyEntriesByDate(
      date: date,
      organizationId: organizationId,
    );

    return result.toEntityList();
  }

  @override
  Future<List<DailyEntry>> getDailyEntriesByDateRange({
    required DateTime fromDate,
    required DateTime toDate,
    required String organizationId,
  }) async {
    final result = await dataSource.getDailyEntriesByDateRange(
      fromDate: fromDate.timestamp,
      toDate: toDate.timestamp,
      organizationId: organizationId,
    );

    return result.toEntityList();
  }

  @override
  Future<String> saveDailyEntries({
    required DateTime date,
    required int boysCount,
    required int girlsCount,
    required String classId,
    required String className,
    required String division,
    required String organizationId,
  }) {
    return dataSource.saveDailyEntries(
      date: date.timestamp,
      boysCount: boysCount,
      girlsCount: girlsCount,
      classId: classId,
      className: className,
      division: division,
      organizationId: organizationId,
    );
  }

  @override
  Future<DailyEntry> getDailyEntryByDateAndClass({
    required DateTime date,
    required String classId,
    required String division,
    required String organizationId,
  }) async {
    final result = await dataSource.getDailyEntryByDateAndClass(
      date: date,
      classId: classId,
      division: division,
      organizationId: organizationId,
    );
    if (result.isEmpty) {
      throw NotFoundException('No entry found for $date');
    }
    final entries = result.toEntityList();
    return entries.first;
  }

  @override
  Future<String> updateDailyEntries({
    required String id,
    required int boysCount,
    required int girlsCount,
  }) {
    return dataSource.updateDailyEntries(
      id: id,
      boysCount: boysCount,
      girlsCount: girlsCount,
    );
  }
}
