import 'package:chss_noon_meal/data/data_source/remote/auth_data_source.dart';
import 'package:chss_noon_meal/domain/entity/auth/user.dart';
import 'package:chss_noon_meal/domain/entity/auth/user_extension.dart';

abstract class AuthRepository {
  Future<User> login({
    required String username,
    required String password,
  });
}

class DefaultAuthRepository implements AuthRepository {
  DefaultAuthRepository({
    required this.dataSource,
  });

  final AuthDataSource dataSource;

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    final result = await dataSource.login(
      username: username,
      password: password,
    );
    return result.toUserEntity();
  }
}
