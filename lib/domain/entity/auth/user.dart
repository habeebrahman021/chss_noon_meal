import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.userName,
    required this.fullName,
    required this.userRole,
    required this.profileImage,
  });

  final String userName;
  final String fullName;
  final int userRole;
  final String profileImage;

  @override
  List<Object?> get props => [
        userName,
        fullName,
        userRole,
        profileImage,
      ];

  User copyWith({
    String? userName,
    String? fullName,
    int? userRole,
    String? profileImage,
  }) {
    return User(
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      userRole: userRole ?? this.userRole,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
