import 'package:chss_noon_meal/data/repository/daily_entry_repository.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class UpdateDailyEntryUseCase
    extends UseCase<String, UpdateDailyEntryUseCaseParams> {
  UpdateDailyEntryUseCase({
    required this.dailyEntryRepository,
  });

  final DailyEntryRepository dailyEntryRepository;

  @override
  Future<String> execute(UpdateDailyEntryUseCaseParams params) async {
    return dailyEntryRepository.updateDailyEntries(
      id: params.id,
      boysCount: params.boysCount,
      girlsCount: params.girlsCount,
    );
  }
}

class UpdateDailyEntryUseCaseParams extends Equatable {
  const UpdateDailyEntryUseCaseParams({
    required this.id,
    required this.boysCount,
    required this.girlsCount,
  });

  final String id;
  final int boysCount;
  final int girlsCount;

  @override
  List<Object?> get props => [
        id,
        boysCount,
        girlsCount,
      ];
}
