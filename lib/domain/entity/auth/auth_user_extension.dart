import 'package:chss_noon_meal/domain/entity/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension UserExtension on User {
  AuthUser toAuthUser() {
    return AuthUser(
      id: uid,
      email: email ?? '',
      displayName: displayName ?? '',
      photoUrl: photoURL ?? '',
    );
  }
}
