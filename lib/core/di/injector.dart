import 'package:chss_noon_meal/data/repository/auth_repository.dart';
import 'package:chss_noon_meal/domain/use_case/auth/login_use_case.dart';
import 'package:chss_noon_meal/presentation/login/bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

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
  injector.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
}

// Data layer dependencies
Future<void> _registerDataSources() async {}

Future<void> _registerRepositories() async {
  injector.registerLazySingleton<AuthRepository>(
    () => DefaultAuthRepository(
      auth: injector(),
    ),
  );
}

// Domain layer dependencies
Future<void> _registerUseCases() async {
  injector.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      authRepository: injector(),
    ),
  );
}

// Presentation layer dependencies
Future<void> _registerBlocs() async {
  injector.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: injector(),
    ),
  );
}
