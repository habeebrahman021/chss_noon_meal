import 'package:chss_noon_meal/data/repository/auth_repository.dart';
import 'package:chss_noon_meal/domain/entity/auth/auth_user.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase extends UseCase<AuthUser, LoginUseCaseParams> {
  LoginUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<AuthUser> execute(LoginUseCaseParams params) {
    return authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginUseCaseParams extends Equatable {
  const LoginUseCaseParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [
    email,
    password,
  ];
}
