import 'dart:async';

import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/extension/date_time_extension.dart';
import 'package:chss_noon_meal/core/extension/either_extension.dart';
import 'package:chss_noon_meal/core/utils.dart';
import 'package:chss_noon_meal/domain/entity/config/class_data.dart';
import 'package:chss_noon_meal/domain/entity/daily_entry/daily_entry.dart';
import 'package:chss_noon_meal/domain/use_case/config/get_class_list_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/export_report_to_excel_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/get_student_entries_by_date_range_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/get_student_entries_by_date_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/update_class_list_with_daily_entries_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_organization_id_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_user_role_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc({
    required this.getSavedUserRoleUseCase,
    required this.getClassListUseCase,
    required this.getDailyEntriesByDateUseCase,
    required this.getDailyEntriesByDateRangeUseCase,
    required this.getSavedOrganizationIdUseCase,
    required this.updateClassListWithDailyEntriesUseCase,
    required this.exportReportToExcelUseCase,
  }) : super(ReportsState()) {
    on<ReportsEvent>((event, emit) {});
    on<ReportsEventInitial>(_onReportsEventInitial);
    on<GetDailyEntriesByDate>(_onGetDailyEntriesByDate);
    on<DateSelected>(_onDateSelected);
    on<StartDateSelected>(_onStartDateSelected);
    on<EndDateSelected>(_onEndDateSelected);
    on<ExportButtonPressed>(_onExportButtonPressed);
  }

  final GetSavedUserRoleUseCase getSavedUserRoleUseCase;
  final GetClassListUseCase getClassListUseCase;
  final GetDailyEntriesByDateUseCase getDailyEntriesByDateUseCase;
  final GetDailyEntriesByDateRangeUseCase getDailyEntriesByDateRangeUseCase;
  final GetSavedOrganizationIdUseCase getSavedOrganizationIdUseCase;
  final UpdateClassListWithDailyEntriesUseCase
      updateClassListWithDailyEntriesUseCase;
  final ExportReportToExcelUseCase exportReportToExcelUseCase;

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

    emit(state.copyWith(classList: getClassListResult.right));

    final isAdmin = state.userRole == 1 || state.userRole == 2;
    // Get Daily Entries
    final getDailyEntriesResult = isAdmin
        ? await getDailyEntriesByDateRangeUseCase(
            GetDailyEntriesByDateRangeUseCaseParams(
              fromDate: state.startDate,
              toDate: state.endDate,
              organizationId: orgId,
            ),
          )
        : await getDailyEntriesByDateUseCase(
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
        startDate: isAdmin ? state.startDate : state.date,
        endDate: isAdmin ? state.endDate : state.date,
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

  Future<void> _onStartDateSelected(
    StartDateSelected event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(startDate: event.date));
    add(GetDailyEntriesByDate());
  }

  Future<void> _onEndDateSelected(
    EndDateSelected event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(endDate: event.date));
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

  Future<void> _onExportButtonPressed(
    ExportButtonPressed event,
    Emitter<ReportsState> emit,
  ) async {
    if (await Permission.storage.request().isGranted) {
      final result = await exportReportToExcelUseCase(
        ExportReportToExcelUseCaseParams(
          classList: state.classList,
          dailyEntryList: state.dailyEntryList,
          startDate: state.startDate,
          endDate: state.endDate,
        ),
      );

      if (result.isRight) {
        final openResult = await OpenFile.open(result.right);
        switch (openResult.type) {
          case ResultType.done:
            break;
          case ResultType.fileNotFound:
            Utils.showToast('File not found');
          case ResultType.noAppToOpen:
            Utils.showToast(
              'No application to open file. File saved to ${result.right}',
            );
          case ResultType.permissionDenied:
            Utils.showToast('Permission denied');
          case ResultType.error:
            Utils.showToast('Error occurred while opening file');
        }
      } else {
        Utils.showToast(result.left.toString());
      }
    } else {
      Utils.showToast(
        'Storage Permission Required. Please grant it from settings.',
      );
    }
  }
}
