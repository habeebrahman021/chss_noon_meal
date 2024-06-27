part of 'daily_entry_bloc.dart';

class DailyEntryState extends Equatable {
  const DailyEntryState({
    this.classList = const [],
  });

  final List<ClassData> classList;

  @override
  List<Object?> get props => [
        classList,
      ];

  DailyEntryState copyWith({
    List<ClassData>? classList,
  }) {
    return DailyEntryState(
      classList: classList ?? this.classList,
    );
  }
}
