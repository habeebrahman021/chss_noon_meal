import 'dart:async';

import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/utils.dart';
import 'package:chss_noon_meal/domain/use_case/auth/login_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/auth/save_user_details_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.saveUserDetailsUseCase,
    required this.loginUseCase,
  }) : super(const LoginState()) {
    on<LoginEvent>((event, emit) {});
    on<EmailTextUpdated>(_onEmailTextUpdated);
    on<PasswordTextUpdated>(_onPasswordTextUpdated);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  final SaveUserDetailsUseCase saveUserDetailsUseCase;
  final LoginUseCase loginUseCase;

  Future<void> _onEmailTextUpdated(
    EmailTextUpdated event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _onPasswordTextUpdated(
    PasswordTextUpdated event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loginStatus: Status.loading));
    final result = await loginUseCase(
      LoginUseCaseParams(
        username: state.email,
        password: state.password,
      ),
    );

    if (result.isRight) {
      // Save Logged User Details
      await saveUserDetailsUseCase(
        SaveUserDetailsUseCaseParams(
          user: result.right,
        ),
      );
      emit(state.copyWith(loginStatus: Status.success));
    } else {
      emit(state.copyWith(loginStatus: Status.failure));
      Utils.showToast(result.left.toString());
    }
  }
}
