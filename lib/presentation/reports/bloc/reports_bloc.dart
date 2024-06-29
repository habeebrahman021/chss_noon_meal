import 'dart:async';

import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/extension/date_time_extension.dart';
import 'package:chss_noon_meal/core/extension/either_extension.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/use_case/config/get_class_list_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/get_student_entries_by_date_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/update_class_list_with_daily_entries_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_organization_id_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_user_role_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc({
    required this.getSavedUserRoleUseCase,
    required this.getClassListUseCase,
    required this.getDailyEntriesByDateUseCase,
    required this.getSavedOrganizationIdUseCase,
    required this.updateClassListWithDailyEntriesUseCase,
  }) : super(ReportsState()) {
    on<ReportsEvent>((event, emit) {});
    on<ReportsEventInitial>(_onReportsEventInitial);
    on<GetDailyEntriesByDate>(_onGetDailyEntriesByDate);
    on<DateSelected>(_onDateSelected);
  }

  final GetSavedUserRoleUseCase getSavedUserRoleUseCase;
  final GetClassListUseCase getClassListUseCase;
  final GetDailyEntriesByDateUseCase getDailyEntriesByDateUseCase;
  final GetSavedOrganizationIdUseCase getSavedOrganizationIdUseCase;
  final UpdateClassListWithDailyEntriesUseCase
      updateClassListWithDailyEntriesUseCase;

  Future<void> _onGetDailyEntriesByDate(
    GetDailyEntriesByDate event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    // Get Organization Id
    final orgIdResult = await getSavedOrganizationIdUseCase(NoParams());
    final orgId = orgIdResult.rightOrNull() ?? '';
    // Get Class List
    final getClassListResult = await getClassListUseCase(NoParams());
    if (getClassListResult.isLeft) {
      state.copyWith(status: Status.failure);
      return;
    }

    // Get Daily Entries
    final getDailyEntriesResult = await getDailyEntriesByDateUseCase(
      GetDailyEntriesByDateUseCaseParams(
        date: state.date,
        organizationId: orgId,
      ),
    );
    if (getDailyEntriesResult.isLeft) {
      state.copyWith(status: Status.failure);
      return;
    }

    // Get UpdatedList
    final result = await updateClassListWithDailyEntriesUseCase(
      UpdateClassListWithDailyEntriesUseCaseParams(
        classList: getClassListResult.right,
        dailyEntries: getDailyEntriesResult.right,
      ),
    );

    if (result.isRight) {
      emit(
        state.copyWith(
          status: Status.success,
          dailyEntryList: result.right,
        ),
      );
    } else {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onDateSelected(
    DateSelected event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(date: event.date));
    add(GetDailyEntriesByDate());
  }

  Future<FutureOr<void>> _onReportsEventInitial(
    ReportsEventInitial event,
    Emitter<ReportsState> emit,
  ) async {
    final result = await getSavedUserRoleUseCase(NoParams());

    if (result.isRight) {
      emit(state.copyWith(userRole: result.right));
    }
  }
}
