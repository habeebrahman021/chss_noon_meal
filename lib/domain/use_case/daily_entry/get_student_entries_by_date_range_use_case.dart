import 'package:chss_noon_meal/data/repository/daily_entry_repository.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class GetDailyEntriesByDateRangeUseCase
    extends UseCase<List<DailyEntry>, GetDailyEntriesByDateRangeUseCaseParams> {
  GetDailyEntriesByDateRangeUseCase({
    required this.repository,
  });

  final DailyEntryRepository repository;

  @override
  Future<List<DailyEntry>> execute(
    GetDailyEntriesByDateRangeUseCaseParams params,
  ) {
    return repository.getDailyEntriesByDateRange(
      fromDate: params.fromDate,
      toDate: params.toDate,
      organizationId: params.organizationId,
    );
  }
}

class GetDailyEntriesByDateRangeUseCaseParams extends Equatable {
  const GetDailyEntriesByDateRangeUseCaseParams({
    required this.fromDate,
    required this.toDate,
    required this.organizationId,
  });

  final DateTime fromDate;
  final DateTime toDate;
  final String organizationId;

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        organizationId,
      ];
}
