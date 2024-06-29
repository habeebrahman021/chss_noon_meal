import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/data/repository/daily_entry_repository.dart';
import 'package:chss_noon_meal/domain/entity/dashboard/chart_data.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class GetStudentEntryCountByDate
    extends UseCase<List<ChartData>, GetStudentEntryCountByDateParams> {
  GetStudentEntryCountByDate({
    required this.preferenceDataSource,
    required this.dailyEntryRepository,
  });

  final PreferenceDataSource preferenceDataSource;
  final DailyEntryRepository dailyEntryRepository;

  @override
  Future<List<ChartData>> execute(
      GetStudentEntryCountByDateParams params) async {
    final organizationId = await preferenceDataSource.getOrganizationId();
    final result = await dailyEntryRepository.getDailyEntriesByDate(
      date: params.date,
      organizationId: organizationId,
    );

    final boysCount =
        result.map((item) => item.boysCount).reduce((a, b) => a + b);
    final girlsCount =
        result.map((item) => item.girlsCount).reduce((a, b) => a + b);
    return [
      ChartData(
        'Boys',
        boysCount.toDouble(),
        AppColors.incentiveColor,
      ),
      ChartData(
        'Girls',
        girlsCount.toDouble(),
        AppColors.commitmentstatusbg,
      ),
    ];
  }
}

class GetStudentEntryCountByDateParams extends Equatable {
  const GetStudentEntryCountByDateParams({
    required this.date,
  });

  final DateTime date;

  @override
  List<Object?> get props => [
        date,
      ];
}
