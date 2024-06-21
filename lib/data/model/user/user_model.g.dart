// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['user_id'] as String?,
      fullName: json['full_name'] as String?,
      userName: json['user_name'] as String?,
      userRole: (json['user_role'] as num?)?.toInt(),
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'user_name': instance.userName,
      'user_role': instance.userRole,
      'profile_image': instance.profileImage,
    };
