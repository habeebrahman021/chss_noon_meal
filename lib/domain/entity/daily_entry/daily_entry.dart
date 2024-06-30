import 'package:equatable/equatable.dart';

class DailyEntry extends Equatable {
  const DailyEntry({
    required this.classId,
    required this.date,
    required this.className,
    required this.division,
    required this.boysCount,
    required this.girlsCount,
    this.id = '',
  });

  final String id;
  final DateTime? date;
  final String classId;
  final String className;
  final String division;
  final int boysCount;
  final int girlsCount;

  @override
  List<Object?> get props => [
        id,
        date,
        classId,
        className,
        division,
        boysCount,
        girlsCount,
      ];
}
