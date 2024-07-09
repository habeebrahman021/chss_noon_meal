import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:chss_noon_meal/data/repository/daily_entry_repository.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/entity/dashboard/chart_data.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class GenerateChartDataUseCase
    extends UseCase<List<ChartData>, GenerateChartDataUseCaseParams> {
  GenerateChartDataUseCase({
    required this.dailyEntryRepository,
  });

  final DailyEntryRepository dailyEntryRepository;

  @override
  Future<List<ChartData>> execute(
    GenerateChartDataUseCaseParams params,
  ) async {
    var boysCount = 0;
    var girlsCount = 0;

    if (params.dailyEntries.isNotEmpty) {
      boysCount = params.dailyEntries.map((item) => item.boysCount).reduce(
            (a, b) => a + b,
          );
      girlsCount = params.dailyEntries.map((item) => item.girlsCount).reduce(
            (a, b) => a + b,
          );
    }
    return [
      ChartData(
        'Boys',
        boysCount,
        AppColors.incentiveColor,
      ),
      ChartData(
        'Girls',
        girlsCount,
        AppColors.commitmentstatusbg,
      ),
    ];
  }
}

class GenerateChartDataUseCaseParams extends Equatable {
  const GenerateChartDataUseCaseParams({
    required this.dailyEntries,
  });

  final List<DailyEntry> dailyEntries;

  @override
  List<Object?> get props => [dailyEntries];
}
