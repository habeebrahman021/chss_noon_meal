import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.userId,
    required this.userName,
    required this.fullName,
    required this.userRole,
    required this.profileImage,
    required this.classId,
    required this.divisionId,
    required this.organizationId,
  });

  final String userId;
  final String userName;
  final String fullName;
  final int userRole;
  final String profileImage;
  final String classId;
  final String divisionId;
  final String organizationId;

  @override
  List<Object?> get props => [
        userId,
        userName,
        fullName,
        userRole,
        profileImage,
        classId,
        divisionId,
        organizationId,
      ];

  User copyWith({
    String? userId,
    String? userName,
    String? fullName,
    int? userRole,
    String? profileImage,
    String? classId,
    String? divisionId,
    String? organizationId,
  }) {
    return User(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      userRole: userRole ?? this.userRole,
      profileImage: profileImage ?? this.profileImage,
      classId: classId ?? this.classId,
      divisionId: divisionId ?? this.divisionId,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}
