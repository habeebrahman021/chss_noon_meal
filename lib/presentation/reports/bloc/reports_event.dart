part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {}

class ReportsEventInitial extends ReportsEvent {
  @override
  List<Object?> get props => [];
}

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

class StartDateSelected extends ReportsEvent {
  StartDateSelected({required this.date});

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class EndDateSelected extends ReportsEvent {
  EndDateSelected({required this.date});

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class ExportButtonPressed extends ReportsEvent {
  @override
  List<Object?> get props => [];
}
