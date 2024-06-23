import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/presentation/home/bloc/home_bloc.dart';
import 'package:chss_noon_meal/presentation/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(LogoutButtonPressed());
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                      ),
                    );
                  },
                ),
              ],
            ),
            body: BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state.logoutStatus.isSuccess) {
                  GoRouter.of(context).pushReplacementNamed(LoginScreen.route);
                }
              },
              child: const Center(
                child: Text('Home'),
              ),
            ),
          );
        },
      ),
    );
  }
}
