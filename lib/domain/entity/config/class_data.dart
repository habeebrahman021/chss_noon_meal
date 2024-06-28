import 'package:equatable/equatable.dart';

class ClassData extends Equatable {
  const ClassData({
    required this.classId,
    required this.className,
    required this.divisions,
  });

  final String classId;
  final String className;
  final List<String> divisions;

  @override
  List<Object?> get props => [
        classId,
        className,
        divisions,
      ];

  ClassData copyWith({
    String? classId,
    String? className,
    List<String>? divisions,
  }) {
    return ClassData(
      classId: classId ?? this.classId,
      className: className ?? this.className,
      divisions: divisions ?? this.divisions,
    );
  }
}
