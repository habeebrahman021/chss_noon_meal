import 'package:chss_noon_meal/core/exceptions.dart';
import 'package:chss_noon_meal/data/model/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
  });
}

class DefaultAuthDataSource implements AuthDataSource {
  DefaultAuthDataSource({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final result = await firestore
        .collection('users')
        .where('user_name', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();

    if (result.docs.isNotEmpty) {
      final userData = result.docs.first.data();
      userData['user_id'] = result.docs.first.id;
      return UserModel.fromJson(userData);
    } else {
      throw ValidationException('Invalid username or password');
    }
  }
}
