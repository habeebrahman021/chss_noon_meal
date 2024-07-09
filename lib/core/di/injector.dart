import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/data/data_source/remote/auth_data_source.dart';
import 'package:chss_noon_meal/data/data_source/remote/config_data_source.dart';
import 'package:chss_noon_meal/data/data_source/remote/daily_entry_data_source.dart';
import 'package:chss_noon_meal/data/repository/auth_repository.dart';
import 'package:chss_noon_meal/data/repository/config_repository.dart';
import 'package:chss_noon_meal/data/repository/daily_entry_repository.dart';
import 'package:chss_noon_meal/domain/use_case/auth/login_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/auth/logout_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/auth/save_user_details_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/config/get_class_list_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/check_entry_exists_with_date_and_class_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/export_report_to_excel_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/get_student_entries_by_date_range_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/get_student_entries_by_date_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/generate_chart_data_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/save_daily_entry_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/update_class_list_with_daily_entries_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/daily_entry/update_daily_entry_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_full_name_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_organization_id_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_user_id_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_user_role_use_case.dart';
import 'package:chss_noon_meal/presentation/home/bloc/home_bloc.dart';
import 'package:chss_noon_meal/presentation/login/bloc/login_bloc.dart';
import 'package:chss_noon_meal/presentation/reports/bloc/reports_bloc.dart';
import 'package:chss_noon_meal/presentation/student_entry/bloc/daily_entry_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

/// Initializes dependencies for the application.
///
/// This function registers all necessary dependencies for different layers of
/// the application (Core, Data, Domain, Presentation) using separate functions
/// for better organization and clarity. The registration happens in the correct
/// dependency order, ensuring that dependencies are available when needed.
///
Future<void> initializeDependencies() async {
  // Core layer
  await _registerCoreDependencies();

  // Data layer
  await _registerDataSources();
  await _registerRepositories();

  // Domain layer
  await _registerUseCases();

  // Presentation layer
  await _registerBlocs();
}

// Register core dependencies
Future<void> _registerCoreDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerSingleton<SharedPreferences>(sharedPreferences);

  // Firebase
  final firestore = FirebaseFirestore.instance;
  injector.registerSingleton<FirebaseFirestore>(firestore);
}

// Data layer dependencies
Future<void> _registerDataSources() async {
  injector
    ..registerLazySingleton<PreferenceDataSource>(
      () => DefaultPreferenceDataSource(
        storage: injector(),
      ),
    )
    ..registerLazySingleton<AuthDataSource>(
      () => DefaultAuthDataSource(
        firestore: injector(),
      ),
    )
    ..registerLazySingleton<DailyEntryDataSource>(
      () => DefaultDailyEntryDataSource(
        firestore: injector(),
      ),
    )
    ..registerLazySingleton<ConfigDataSource>(
      () => DefaultConfigDataSource(
        firestore: injector(),
      ),
    );
}

Future<void> _registerRepositories() async {
  injector
    ..registerLazySingleton<AuthRepository>(
      () => DefaultAuthRepository(
        dataSource: injector(),
      ),
    )
    ..registerLazySingleton<DailyEntryRepository>(
      () => DefaultDailyEntryRepository(
        dataSource: injector(),
      ),
    )
    ..registerLazySingleton<ConfigRepository>(
      () => DefaultConfigRepository(
        dataSource: injector(),
      ),
    );
}

// Domain layer dependencies
Future<void> _registerUseCases() async {
  injector
    ..registerLazySingleton<SaveUserDetailsUseCase>(
      () => SaveUserDetailsUseCase(
        preferenceDataSource: injector(),
      ),
    )
    ..registerLazySingleton<GetSavedUserIdUseCase>(
      () => GetSavedUserIdUseCase(
        preferenceDataSource: injector(),
      ),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(
        authRepository: injector(),
      ),
    )
    ..registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(
        preferenceDataSource: injector(),
      ),
    )
    ..registerLazySingleton<GetDailyEntriesByDateUseCase>(
      () => GetDailyEntriesByDateUseCase(
        repository: injector(),
      ),
    )
    ..registerLazySingleton<GetDailyEntriesByDateRangeUseCase>(
      () => GetDailyEntriesByDateRangeUseCase(
        repository: injector(),
      ),
    )
    ..registerLazySingleton<SaveDailyEntryUseCase>(
      () => SaveDailyEntryUseCase(
        preferenceDataSource: injector(),
        dailyEntryRepository: injector(),
      ),
    )
    ..registerLazySingleton<GetClassListUseCase>(
      () => GetClassListUseCase(
        repository: injector(),
        preferenceDataSource: injector(),
      ),
    )
    ..registerLazySingleton<UpdateClassListWithDailyEntriesUseCase>(
      UpdateClassListWithDailyEntriesUseCase.new,
    )
    ..registerLazySingleton<GetSavedOrganizationIdUseCase>(
      () => GetSavedOrganizationIdUseCase(
        preferenceDataSource: injector(),
      ),
    )
    ..registerLazySingleton<UpdateDailyEntryUseCase>(
      () => UpdateDailyEntryUseCase(
        dailyEntryRepository: injector(),
      ),
    )
    ..registerLazySingleton<CheckEntryExistsWithDateAndClassUseCase>(
      () => CheckEntryExistsWithDateAndClassUseCase(
        preferenceDataSource: injector(),
        repository: injector(),
      ),
    )
    ..registerLazySingleton<GetSavedFullNameUseCase>(
      () => GetSavedFullNameUseCase(
        preferenceDataSource: injector(),
      ),
    )
    ..registerLazySingleton<GenerateChartDataUseCase>(
      () => GenerateChartDataUseCase(
        dailyEntryRepository: injector(),
      ),
    )
    ..registerLazySingleton<GetSavedUserRoleUseCase>(
      () => GetSavedUserRoleUseCase(
        preferenceDataSource: injector(),
      ),
    )
    ..registerLazySingleton<ExportReportToExcelUseCase>(
      ExportReportToExcelUseCase.new,
    );
}

// Presentation layer dependencies
Future<void> _registerBlocs() async {
  injector
    ..registerFactory<LoginBloc>(
      () => LoginBloc(
        saveUserDetailsUseCase: injector(),
        loginUseCase: injector(),
      ),
    )
    ..registerFactory<HomeBloc>(
      () => HomeBloc(
        logoutUseCase: injector(),
        generateChartDataUseCase: injector(),
        getSavedFullNameUseCase: injector(),
        getClassListUseCase: injector(),
        getDailyEntriesByDateUseCase: injector(),
        updateClassListWithDailyEntriesUseCase: injector(),
        getSavedOrganizationIdUseCase: injector(),
      )
        ..add(HomeEventInitial())
        ..add(GetStudentEntryCount()),
    )
    ..registerFactory<DailyEntryBloc>(
      () => DailyEntryBloc(
        saveDailyEntryUseCase: injector(),
        getClassListUseCase: injector(),
        checkEntryExistsWithDateAndClassUseCase: injector(),
        updateDailyEntryUseCase: injector(),
      )..add(GetClassList()),
    )
    ..registerFactory<ReportsBloc>(
      () => ReportsBloc(
        getSavedUserRoleUseCase: injector(),
        getClassListUseCase: injector(),
        getDailyEntriesByDateUseCase: injector(),
        getDailyEntriesByDateRangeUseCase: injector(),
        updateClassListWithDailyEntriesUseCase: injector(),
        getSavedOrganizationIdUseCase: injector(),
        exportReportToExcelUseCase: injector(),
      )
        ..add(ReportsEventInitial())
        ..add(GetDailyEntriesByDate()),
    );
}
