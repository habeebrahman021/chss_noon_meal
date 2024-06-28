// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassListModel _$ClassListModelFromJson(Map<String, dynamic> json) =>
    ClassListModel(
      classId: json['class_id'] as String?,
      name: json['name'] as String?,
      divisions: (json['divisions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      organizationId: json['organization_id'] as String?,
    );

Map<String, dynamic> _$ClassListModelToJson(ClassListModel instance) =>
    <String, dynamic>{
      'class_id': instance.classId,
      'name': instance.name,
      'divisions': instance.divisions,
      'organization_id': instance.organizationId,
    };
