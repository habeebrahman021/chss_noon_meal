import 'package:chss_noon_meal/data/repository/daily_entry_repository.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class SaveDailyEntryUseCase
    extends UseCase<String, SaveDailyEntryUseCaseParams> {
  SaveDailyEntryUseCase({
    required this.dailyEntryRepository,
  });

  final DailyEntryRepository dailyEntryRepository;

  @override
  Future<String> execute(SaveDailyEntryUseCaseParams params) {
    return dailyEntryRepository.saveDailyEntries(
      date: params.date,
      boysCount: params.boysCount,
      girlsCount: params.girlsCount,
      classId: params.classId,
      className: params.className,
      division: params.division,
      organizationId: params.organizationId,
    );
  }
}

class SaveDailyEntryUseCaseParams extends Equatable {
  const SaveDailyEntryUseCaseParams({
    required this.date,
    required this.boysCount,
    required this.girlsCount,
    required this.classId,
    required this.className,
    required this.division,
    required this.organizationId,
  });

  final String date;
  final int boysCount;
  final int girlsCount;
  final String classId;
  final String className;
  final String division;
  final String organizationId;

  @override
  List<Object?> get props => [
        date,
        boysCount,
        girlsCount,
        classId,
        className,
        division,
        organizationId,
      ];
}
