import 'dart:async';

import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/extension/either_extension.dart';
import 'package:chss_noon_meal/domain/entity/dashboard/chart_data.dart';
import 'package:chss_noon_meal/domain/use_case/auth/logout_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/config/get_class_list_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/generate_chart_data_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/get_student_entries_by_date_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/update_class_list_with_daily_entries_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_full_name_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_organization_id_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.logoutUseCase,
    required this.getSavedFullNameUseCase,
    required this.getClassListUseCase,
    required this.getDailyEntriesByDateUseCase,
    required this.updateClassListWithDailyEntriesUseCase,
    required this.getSavedOrganizationIdUseCase,
    required this.generateChartDataUseCase,
  }) : super(HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
    on<GetStudentEntryCount>(_onGetStudentEntryCount);
    on<HomeEventInitial>(_onHomeEventInitial);
  }

  final LogoutUseCase logoutUseCase;
  final GetClassListUseCase getClassListUseCase;
  final GetDailyEntriesByDateUseCase getDailyEntriesByDateUseCase;
  final UpdateClassListWithDailyEntriesUseCase
      updateClassListWithDailyEntriesUseCase;
  final GetSavedFullNameUseCase getSavedFullNameUseCase;
  final GetSavedOrganizationIdUseCase getSavedOrganizationIdUseCase;
  final GenerateChartDataUseCase generateChartDataUseCase;

  Future<void> _onLogoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<HomeState> emit,
  ) async {
    final result = await logoutUseCase(NoParams());
    if (result.isRight) {
      emit(state.copyWith(logoutStatus: Status.success));
    } else {
      emit(state.copyWith(logoutStatus: Status.failure));
    }
  }

  Future<void> _onGetStudentEntryCount(
    GetStudentEntryCount event,
    Emitter<HomeState> emit,
  ) async {
    final orgIdResult = await getSavedOrganizationIdUseCase(NoParams());
    final orgId = orgIdResult.rightOrNull() ?? '';
    final getClassListResult = await getClassListUseCase(NoParams());
    if (getClassListResult.isLeft) {
      return;
    }

    final getDailyEntriesResult = await getDailyEntriesByDateUseCase(
      GetDailyEntriesByDateUseCaseParams(
        date: state.date,
        organizationId: orgId,
      ),
    );
    if (getDailyEntriesResult.isLeft) {
      return;
    }

    // Get UpdatedList
    final result = await updateClassListWithDailyEntriesUseCase(
      UpdateClassListWithDailyEntriesUseCaseParams(
        classList: getClassListResult.right,
        dailyEntries: getDailyEntriesResult.right,
        startDate: state.date,
        endDate: state.date,
      ),
    );

    if (result.isLeft) {
      return;
    }

    final chartData = await generateChartDataUseCase(
      GenerateChartDataUseCaseParams(
        dailyEntries: result.right,
      ),
    );

    if (chartData.isLeft) {
      return;
    }
    emit(state.copyWith(chartData: chartData.right));
  }

  Future<void> _onHomeEventInitial(
    HomeEventInitial event,
    Emitter<HomeState> emit,
  ) async {
    final result = await getSavedFullNameUseCase(NoParams());

    if (result.isRight) {
      emit(state.copyWith(fullName: result.right));
    }
  }
}
