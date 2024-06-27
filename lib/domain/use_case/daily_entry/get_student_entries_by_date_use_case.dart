import 'package:chss_noon_meal/data/repository/daily_entry_repository.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class GetDailyEntriesByDateUseCase
    extends UseCase<List<DailyEntry>, GetDailyEntriesByDateUseCaseParams> {
  GetDailyEntriesByDateUseCase({required this.repository});

  final DailyEntryRepository repository;

  @override
  Future<List<DailyEntry>> execute(
    GetDailyEntriesByDateUseCaseParams params,
  ) {
    return repository.getDailyEntriesByDate(
      date: params.date,
      organizationId: params.organizationId,
    );
  }
}

class GetDailyEntriesByDateUseCaseParams extends Equatable {
  const GetDailyEntriesByDateUseCaseParams({
    required this.date,
    required this.organizationId,
  });

  final DateTime date;
  final String organizationId;

  @override
  List<Object?> get props => [
        date,
        organizationId,
      ];
}
