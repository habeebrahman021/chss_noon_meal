part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {}

class GetDailyEntriesByDate extends ReportsEvent {
  @override
  List<Object?> get props => [];
}

class DateSelected extends ReportsEvent {
  DateSelected({required this.date});

  final DateTime date;

  @override
  List<Object?> get props => [date];
}
