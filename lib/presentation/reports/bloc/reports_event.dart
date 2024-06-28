part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {}

class GetDailyEntriesByDate extends ReportsEvent {
  @override
  List<Object?> get props => [];
}
