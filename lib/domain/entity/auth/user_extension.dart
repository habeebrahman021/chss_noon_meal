import 'package:chss_noon_meal/data/model/user/user_model.dart';
import 'package:chss_noon_meal/domain/entity/auth/user.dart';

extension UserExtension on UserModel {
  User toUserEntity() {
    return User(
      userName: userName ?? '',
      fullName: fullName ?? '',
      userRole: userRole ?? 0,
      profileImage: profileImage ?? '',
    );
  }
}
