import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

/// Initializes dependencies for the application.
///
/// This function registers all necessary dependencies for different layers of
/// the application (Core, Data, Domain, Presentation) using separate functions
/// for better organization and clarity. The registration happens in the correct
/// dependency order, ensuring that dependencies are available when needed.
///
Future<void> initializeDependencies() async {}
