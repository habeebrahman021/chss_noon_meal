part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  ReportsState({
    this.userRole = 3,
    DateTime? date,
    DateTime? startDate,
    DateTime? endDate,
    this.status = Status.initial,
    this.dailyEntryList = const [],
    this.classList = const [],
  })  : date = date ?? DateTime.now(),
        startDate = startDate ?? DateTime.now().firstDayOfMonth,
        endDate = endDate ?? DateTime.now();

  final int userRole; // 1 => Super Admin 2 => Organization Admin 3 => Teacher
  final DateTime date;
  final DateTime startDate;
  final DateTime endDate;
  final List<ClassData> classList;
  final List<DailyEntry> dailyEntryList;
  final Status status;

  String get formattedDate {
    return date.toStringFormatted('dd MMM yyyy');
  }

  String get formattedStartDate {
    return startDate.toStringFormatted('dd MMM yyyy');
  }

  String get formattedEndDate {
    return endDate.toStringFormatted('dd MMM yyyy');
  }

  @override
  List<Object?> get props => [
        userRole,
        dailyEntryList,
        classList,
        date,
        startDate,
        endDate,
        status,
      ];

  ReportsState copyWith({
    int? userRole,
    DateTime? date,
    DateTime? startDate,
    DateTime? endDate,
    List<ClassData>? classList,
    List<DailyEntry>? dailyEntryList,
    Status? status,
  }) {
    return ReportsState(
      userRole: userRole ?? this.userRole,
      date: date ?? this.date,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      classList: classList ?? this.classList,
      dailyEntryList: dailyEntryList ?? this.dailyEntryList,
      status: status ?? this.status,
    );
  }
}
