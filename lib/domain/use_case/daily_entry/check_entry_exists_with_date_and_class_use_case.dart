import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/data/repository/daily_entry_repository.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';

class CheckEntryExistsWithDateAndClassUseCase
    extends UseCase<DailyEntry, CheckEntryExistsWithDateAndClassUseCaseParams> {
  CheckEntryExistsWithDateAndClassUseCase({
    required this.preferenceDataSource,
    required this.repository,
  });

  final PreferenceDataSource preferenceDataSource;
  final DailyEntryRepository repository;

  @override
  Future<DailyEntry> execute(
      CheckEntryExistsWithDateAndClassUseCaseParams params,
  ) async {
    final orgId = await preferenceDataSource.getOrganizationId();
    return repository.getDailyEntryByDateAndClass(
      date: params.date,
      classId: params.classId,
      division: params.division,
      organizationId: orgId,
    );
  }
}

class CheckEntryExistsWithDateAndClassUseCaseParams {
  CheckEntryExistsWithDateAndClassUseCaseParams({
    required this.date,
    required this.classId,
    required this.division,
  });

  final DateTime date;
  final String classId;
  final String division;
}
