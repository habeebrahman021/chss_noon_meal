import 'dart:async';

import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/exceptions.dart';
import 'package:chss_noon_meal/core/utils.dart';
import 'package:chss_noon_meal/domain/entity/config/class_data.dart';
import 'package:chss_noon_meal/domain/use_case/config/get_class_list_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/check_entry_exists_with_date_and_class_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/save_daily_entry_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/update_daily_entry_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'daily_entry_event.dart';

part 'daily_entry_state.dart';

class DailyEntryBloc extends Bloc<DailyEntryEvent, DailyEntryState> {
  DailyEntryBloc({
    required this.checkEntryExistsWithDateAndClassUseCase,
    required this.getClassListUseCase,
    required this.saveDailyEntryUseCase,
    required this.updateDailyEntryUseCase,
  }) : super(DailyEntryState()) {
    on<DailyEntryEvent>((event, emit) {});
    on<GetClassList>(_onGetClassList);
    on<ClassSelected>(_onSelectClass);
    on<DivisionSelected>(_onSelectDivision);
    on<BoysCountChanged>(_onBoysCountChanged);
    on<GirlsCountChanged>(_onGirlsCountChanged);
    on<SaveButtonPressed>(_onSaveButtonPressed);

    on<CheckEntryExists>(_onCheckEntryExists);
  }

  final CheckEntryExistsWithDateAndClassUseCase
      checkEntryExistsWithDateAndClassUseCase;
  final GetClassListUseCase getClassListUseCase;
  final SaveDailyEntryUseCase saveDailyEntryUseCase;
  final UpdateDailyEntryUseCase updateDailyEntryUseCase;

  Future<void> _onGetClassList(
    GetClassList event,
    Emitter<DailyEntryState> emit,
  ) async {
    final result = await getClassListUseCase(NoParams());
    if (result.isRight) {
      emit(state.copyWith(classList: result.right));
      if (result.right.length == 1) {
        emit(state.copyWith(selectedClass: result.right.first));
        add(ClassSelected(classData: result.right.first));
      }
    }
  }

  Future<void> _onSelectClass(
    ClassSelected event,
    Emitter<DailyEntryState> emit,
  ) async {
    emit(state.copyWith(selectedClass: event.classData));
    checkIsEntryExists();
  }

  Future<void> _onSelectDivision(
    DivisionSelected event,
    Emitter<DailyEntryState> emit,
  ) async {
    emit(state.copyWith(selectedDivision: event.division));
    checkIsEntryExists();
  }

  Future<FutureOr<void>> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<DailyEntryState> emit,
  ) async {
    if (state.isUpdateMode && state.entryId.isNotEmpty) {
      await updateEntry(emit);
    } else {
      await saveEntry(emit);
    }
  }

  Future<void> _onBoysCountChanged(
    BoysCountChanged event,
    Emitter<DailyEntryState> emit,
  ) async {
    emit(state.copyWith(boysCount: event.count));
  }

  Future<void> _onGirlsCountChanged(
    GirlsCountChanged event,
    Emitter<DailyEntryState> emit,
  ) async {
    emit(state.copyWith(girlsCount: event.count));
  }

  Future<void> _onCheckEntryExists(
    CheckEntryExists event,
    Emitter<DailyEntryState> emit,
  ) async {
    emit(state.copyWith(fetchStatus: Status.loading));
    final result = await checkEntryExistsWithDateAndClassUseCase(
      CheckEntryExistsWithDateAndClassUseCaseParams(
        date: state.date,
        classId: state.selectedClass?.classId ?? '',
        division: state.selectedDivision ?? '',
      ),
    );

    if (result.isRight) {
      emit(
        state.copyWith(
          fetchStatus: Status.success,
          isUpdateMode: true,
          entryId: result.right.id,
          boysCount: result.right.boysCount.toString(),
          girlsCount: result.right.girlsCount.toString(),
        ),
      );
    } else {
      if (result.left is NotFoundException) {
        emit(
          state.copyWith(
            fetchStatus: Status.success,
            isUpdateMode: false,
            entryId: '',
            boysCount: '',
            girlsCount: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: Status.failure,
            fetchStatus: Status.failure,
          ),
        );
        Utils.showToast(result.left.toString());
      }
    }
  }

  void checkIsEntryExists() {
    if (state.selectedClass != null && state.selectedDivision != null) {
      add(CheckEntryExists());
    }
  }

  Future<void> saveEntry(
    Emitter<DailyEntryState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final boysCount = int.tryParse(state.boysCount) ?? 0;
    final girlsCount = int.tryParse(state.girlsCount) ?? 0;
    final classId = state.selectedClass?.classId ?? '';
    final className = state.selectedClass?.className ?? '';
    final division = state.selectedDivision ?? '';
    final result = await saveDailyEntryUseCase(
      SaveDailyEntryUseCaseParams(
        date: state.date,
        boysCount: boysCount,
        girlsCount: girlsCount,
        classId: classId,
        className: className,
        division: division,
      ),
    );

    if (result.isRight) {
      emit(state.copyWith(status: Status.success));
      Utils.showToast('Daily entry saved successfully');
    } else {
      emit(state.copyWith(status: Status.failure));
      Utils.showToast(result.left.toString());
    }
  }

  Future<void> updateEntry(
    Emitter<DailyEntryState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final boysCount = int.tryParse(state.boysCount) ?? 0;
    final girlsCount = int.tryParse(state.girlsCount) ?? 0;

    final result = await updateDailyEntryUseCase(
      UpdateDailyEntryUseCaseParams(
        id: state.entryId,
        boysCount: boysCount,
        girlsCount: girlsCount,
      ),
    );

    if (result.isRight) {
      emit(state.copyWith(status: Status.success));
      Utils.showToast('Daily entry updated successfully');
    } else {
      emit(state.copyWith(status: Status.failure));
      Utils.showToast(result.left.toString());
    }
  }
}
