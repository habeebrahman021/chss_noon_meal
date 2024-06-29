part of 'daily_entry_bloc.dart';

abstract class DailyEntryEvent extends Equatable {}

class GetClassList extends DailyEntryEvent {
  @override
  List<Object?> get props => [];
}

class ClassSelected extends DailyEntryEvent {
  ClassSelected({
    required this.classData,
  });

  final ClassData classData;

  @override
  List<Object?> get props => [classData];
}

class DivisionSelected extends DailyEntryEvent {
  DivisionSelected({
    required this.division,
  });

  final String division;

  @override
  List<Object?> get props => [division];
}

class BoysCountChanged extends DailyEntryEvent {
  BoysCountChanged({
    required this.count,
  });

  final String count;

  @override
  List<Object?> get props => [count];
}

class GirlsCountChanged extends DailyEntryEvent {
  GirlsCountChanged({
    required this.count,
  });

  final String count;

  @override
  List<Object?> get props => [count];
}

class CheckEntryExists extends DailyEntryEvent {
  @override
  List<Object?> get props => [];
}

class SaveButtonPressed extends DailyEntryEvent {
  @override
  List<Object?> get props => [];
}
