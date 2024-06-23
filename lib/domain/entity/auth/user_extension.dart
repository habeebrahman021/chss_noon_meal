import 'package:chss_noon_meal/data/model/user/user_model.dart';
import 'package:chss_noon_meal/domain/entity/auth/user.dart';

extension UserExtension on UserModel {
  User toUserEntity() {
    return User(
      userId: userId ?? '',
      userName: userName ?? '',
      fullName: fullName ?? '',
      userRole: userRole ?? -1,
      profileImage: profileImage ?? '',
      classId: classId ?? '',
      divisionId: divisionId ?? '',
      organizationId: organizationId ?? '',
    );
  }
}
