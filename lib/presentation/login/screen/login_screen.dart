import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/presentation/home/screen/home_screen.dart';
import 'package:chss_noon_meal/presentation/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.loginStatus.isSuccess) {
              GoRouter.of(context).pushReplacementNamed(HomeScreen.route);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: 'Email'),
                    onChanged: (value) {
                      context
                          .read<LoginBloc>()
                          .add(EmailTextUpdated(email: value));
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Password'),
                    onChanged: (value) {
                      context
                          .read<LoginBloc>()
                          .add(PasswordTextUpdated(password: value));
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(const LoginButtonPressed());
                    },
                    child: const Text('Login'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
