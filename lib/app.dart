import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/route/app_router.dart';
import 'package:chss_noon_meal/core/theme/app_themes.dart';
import 'package:chss_noon_meal/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> app() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppThemes.light,
      darkTheme: AppThemes.light,
      title: 'CHSS Noon Meal',
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
    );
  }
}
