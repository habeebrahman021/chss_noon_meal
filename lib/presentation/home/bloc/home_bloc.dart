import 'dart:async';

import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/domain/entity/dashboard/chart_data.dart';
import 'package:chss_noon_meal/domain/use_case/auth/logout_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/get_student_entry_count_by_date.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_full_name_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.logoutUseCase,
    required this.getStudentEntryCountByDate,
    required this.getSavedFullNameUseCase,
  }) : super(HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
    on<GetStudentEntryCount>(_onGetStudentEntryCount);
    on<HomeEventInitial>(_onHomeEventInitial);
  }

  final LogoutUseCase logoutUseCase;
  final GetStudentEntryCountByDate getStudentEntryCountByDate;
  final GetSavedFullNameUseCase getSavedFullNameUseCase;

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
    final result = await getStudentEntryCountByDate(
      GetStudentEntryCountByDateParams(
        date: DateTime.now(),
      ),
    );

    if (result.isRight) {
      emit(state.copyWith(chartData: result.right));
    }
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
