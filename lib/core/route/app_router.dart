import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/presentation/home/screen/home_screen.dart';
import 'package:chss_noon_meal/presentation/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) async {
      final preference = injector<PreferenceDataSource>();
      final userId = await preference.getUserId();
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
