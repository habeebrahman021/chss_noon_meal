import 'package:chss_noon_meal/data/data_source/remote/daily_entry_data_source.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry_extension.dart';

abstract class DailyEntryRepository {
  Future<List<DailyEntry>> getDailyEntries({
    required String date,
    required String organizationId,
  });
}

class DefaultDailyEntryRepository implements DailyEntryRepository {
  DefaultDailyEntryRepository({required this.dataSource});

  final DailyEntryDataSource dataSource;

  @override
  Future<List<DailyEntry>> getDailyEntries({
    required String date,
    required String organizationId,
  }) async {
    final result = await dataSource.getDailyEntries(
      date: date,
      organizationId: organizationId,
    );

    return result.toEntityList();
  }
}
