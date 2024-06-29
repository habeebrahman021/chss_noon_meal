part of 'daily_entry_bloc.dart';

class DailyEntryState extends Equatable {
  DailyEntryState({
    DateTime? date,
    this.classList = const [],
    this.selectedClass,
    this.selectedDivision,
    this.boysCount = '',
    this.girlsCount = '',
    this.status = Status.initial,
    this.fetchStatus = Status.initial,
    this.isUpdateMode = false,
    this.entryId = '',
  }) : date = date ?? DateTime.now();

  final DateTime date;
  final List<ClassData> classList;
  final ClassData? selectedClass;
  final String? selectedDivision;
  final String boysCount;
  final String girlsCount;

  final Status status;
  final Status fetchStatus;

  final bool isUpdateMode;
  final String entryId;

  String get selectedClassName {
    if (selectedClass == null) {
      return '';
    }
    return 'Class ${selectedClass?.className ?? ''}';
  }

  bool get isButtonEnabled {
    if (selectedClass == null ||
        selectedDivision == null ||
        boysCount.isEmpty ||
        girlsCount.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  List<Object?> get props => [
        classList,
        selectedClass,
        selectedDivision,
        boysCount,
        girlsCount,
        date,
        status,
        fetchStatus,
        isUpdateMode,
        entryId,
      ];

  DailyEntryState copyWith({
    DateTime? date,
    List<ClassData>? classList,
    ClassData? selectedClass,
    String? selectedDivision,
    String? boysCount,
    String? girlsCount,
    Status? status,
    Status? fetchStatus,
    bool? isUpdateMode,
    String? entryId,
  }) {
    return DailyEntryState(
      date: date ?? this.date,
      classList: classList ?? this.classList,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedDivision: selectedDivision ?? this.selectedDivision,
      boysCount: boysCount ?? this.boysCount,
      girlsCount: girlsCount ?? this.girlsCount,
      status: status ?? this.status,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      isUpdateMode: isUpdateMode ?? this.isUpdateMode,
      entryId: entryId ?? this.entryId,
    );
  }
}
