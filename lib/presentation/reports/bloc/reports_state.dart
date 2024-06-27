part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  ReportsState({
    DateTime? date,
    this.status = Status.initial,
    this.dailyEntryList = const [],
  }) : date = date ?? DateTime.now();

  final DateTime date;
  final List<DailyEntry> dailyEntryList;
  final Status status;

  @override
  List<Object?> get props => [
        dailyEntryList,
        date,
        status,
      ];

  ReportsState copyWith({
    DateTime? date,
    List<DailyEntry>? dailyEntryList,
    Status? status,
  }) {
    return ReportsState(
      date: date ?? this.date,
      dailyEntryList: dailyEntryList ?? this.dailyEntryList,
      status: status ?? this.status,
    );
  }
}
