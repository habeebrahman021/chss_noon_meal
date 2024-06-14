part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class EmailTextUpdated extends LoginEvent {
  const EmailTextUpdated({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordTextUpdated extends LoginEvent {
  const PasswordTextUpdated({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed();

  @override
  List<Object?> get props => [];
}
