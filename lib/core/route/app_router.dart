import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/extension/either_extension.dart';
import 'package:chss_noon_meal/domain/use_case/preference/get_saved_user_id_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:chss_noon_meal/presentation/home/screen/home_screen.dart';
import 'package:chss_noon_meal/presentation/login/screen/login_screen.dart';
import 'package:chss_noon_meal/presentation/reports/screen/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/student_entry/screen/daily_entry_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: LoginScreen.route,
    routes: [
      GoRoute(
        path: LoginScreen.route,
        name: LoginScreen.route,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.route,
        name: HomeScreen.route,
        builder: (context, state) =>  HomeScreen(),
      ),
      GoRoute(
        path: DailyEntryScreen.route,
        name: DailyEntryScreen.route,
        builder: (context, state) =>  DailyEntryScreen(),
      ),
      GoRoute(
        path: ReportScreen.route,
        name: ReportScreen.route,
        builder: (context, state) =>  ReportScreen(),
      ),
    ],
    redirect: (context, state) async {
      final getUserIdUseCase = injector<GetSavedUserIdUseCase>();
      final result = await getUserIdUseCase(NoParams());

      final userId = result.rightOrNull() ?? '';
      final loggedIn = userId.isNotEmpty;

      final loggingIn = state.fullPath == LoginScreen.route;

      if (!loggedIn) {
        return loggingIn ? null : LoginScreen.route;
      } else {
        if (loggingIn) {
          return HomeScreen.route;
        }
      }
      return null;
    },
  );
}
