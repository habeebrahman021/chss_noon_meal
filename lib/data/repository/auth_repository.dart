import 'package:chss_noon_meal/core/exceptions.dart';
import 'package:chss_noon_meal/domain/entity/auth/auth_user.dart';
import 'package:chss_noon_meal/domain/entity/auth/auth_user_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}

class DefaultAuthRepository implements AuthRepository {
  DefaultAuthRepository({
    required this.auth,
  });

  final FirebaseAuth auth;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user == null) {
        throw ValidationException('Invalid email or password');
      }
      return credentials.user!.toAuthUser();
    } on FirebaseAuthException catch (_) {
      throw ValidationException('Invalid email or password');
    } catch (e) {
      throw FailureException(e.toString());
    }
  }

  @override
  Future<void> logout() {
    try {
      return auth.signOut();
    } catch (e) {
      throw FailureException(e.toString());
    }
  }
}
