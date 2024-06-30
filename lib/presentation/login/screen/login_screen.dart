import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:chss_noon_meal/presentation/home/screen/home_screen.dart';
import 'package:chss_noon_meal/presentation/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<LoginBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.loginStatus.isSuccess) {
              GoRouter.of(context).pushReplacementNamed(HomeScreen.route);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(60),
                      Center(
                        child: Image.asset(
                          'images/login_bg.jpg',
                          height: 250,
                          width: double.infinity, // Set the desired height
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.roundedRectangularBorderColor,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Sign in to your Existing Account of\nGlobal Brands',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.commentTextColor,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      const Gap(35),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            hintStyle:
                                const TextStyle(color: AppColors.textColor),
                            filled: true,
                            fillColor: AppColors.lightGrey,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(EmailTextUpdated(email: value));
                          },
                        ),
                      ),
                      const Gap(35),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                const TextStyle(color: AppColors.textColor),
                            filled: true,
                            fillColor: AppColors.lightGrey,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(PasswordTextUpdated(password: value));
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<LoginBloc>()
                              .add(const LoginButtonPressed());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.app_color,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
