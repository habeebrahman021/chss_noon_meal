part of 'home_bloc.dart';

class HomeState extends Equatable {
  HomeState({
    DateTime? date,
    this.fullName = '',
    this.logoutStatus = Status.initial,
    this.chartData = const [],
  }) : date = date ?? DateTime.now();

  final DateTime date;
  final Status logoutStatus;
  final List<ChartData> chartData;
  final String fullName;

  String get totalCount {
    if (chartData.isEmpty) {
      return '0';
    }
    return chartData
        .map((data) => data.y)
        .reduce((value, element) => value + element)
        .toString();
  }

  @override
  List<Object?> get props => [
        date,
        logoutStatus,
        chartData,
        fullName,
      ];

  HomeState copyWith({
    DateTime? date,
    Status? logoutStatus,
    List<ChartData>? chartData,
    String? fullName,
  }) {
    return HomeState(
      date: date ?? this.date,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      chartData: chartData ?? this.chartData,
      fullName: fullName ?? this.fullName,
    );
  }
}
