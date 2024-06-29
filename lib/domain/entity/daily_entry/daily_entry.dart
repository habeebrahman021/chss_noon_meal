import 'package:equatable/equatable.dart';

class DailyEntry extends Equatable {
  const DailyEntry({
    required this.classId,
    required this.className,
    required this.division,
    required this.boysCount,
    required this.girlsCount,
    this.id = '',
  });

  final String id;
  final String classId;
  final String className;
  final String division;
  final int boysCount;
  final int girlsCount;

  @override
  List<Object?> get props => [
        id,
        classId,
        className,
        division,
        boysCount,
        girlsCount,
      ];
}
