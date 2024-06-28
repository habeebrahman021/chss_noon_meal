part of 'daily_entry_bloc.dart';

abstract class DailyEntryEvent extends Equatable {}

class GetClassList extends DailyEntryEvent {
  @override
  List<Object?> get props => [];
}
