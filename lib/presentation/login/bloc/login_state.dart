part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.loginStatus = Status.initial,
  });

  final String email;
  final String password;
  final Status loginStatus;

  @override
  List<Object?> get props => [
        email,
        password,
        loginStatus,
      ];

  LoginState copyWith({
    String? email,
    String? password,
    Status? loginStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }
}
