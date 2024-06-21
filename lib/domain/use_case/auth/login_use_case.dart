import 'package:chss_noon_meal/data/repository/auth_repository.dart';
import 'package:chss_noon_meal/domain/entity/auth/user.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase extends UseCase<User, LoginUseCaseParams> {
  LoginUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<User> execute(LoginUseCaseParams params) {
    return authRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginUseCaseParams extends Equatable {
  const LoginUseCaseParams({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => [
    username,
    password,
  ];
}
