part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  ReportsState({
    this.userRole = 3,
    DateTime? date,
    this.status = Status.initial,
    this.dailyEntryList = const [],
  }) : date = date ?? DateTime.now();

  final int userRole; // 1 => Super Admin 2 => Organization Admin 3 => Teacher
  final DateTime date;
  final List<DailyEntry> dailyEntryList;
  final Status status;

  String get formattedDate {
    return date.toStringFormatted('dd MMM yyyy');
  }

  @override
  List<Object?> get props => [
        userRole,
        dailyEntryList,
        date,
        status,
      ];

  ReportsState copyWith({
    int? userRole,
    DateTime? date,
    List<DailyEntry>? dailyEntryList,
    Status? status,
  }) {
    return ReportsState(
      userRole: userRole ?? this.userRole,
      date: date ?? this.date,
      dailyEntryList: dailyEntryList ?? this.dailyEntryList,
      status: status ?? this.status,
    );
  }
}
