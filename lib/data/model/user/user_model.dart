import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    this.userId,
    this.fullName,
    this.userName,
    this.userRole,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'user_name')
  final String? userName;
  @JsonKey(name: 'user_role')
  final int? userRole;
  @JsonKey(name: 'profile_image')
  final String? profileImage;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
