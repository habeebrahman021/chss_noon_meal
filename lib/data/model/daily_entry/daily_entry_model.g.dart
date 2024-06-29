// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyEntryModel _$DailyEntryModelFromJson(Map<String, dynamic> json) =>
    DailyEntryModel(
      id: json['id'] as String?,
      date: json['date'] as Timestamp?,
      boysCount: (json['boys_count'] as num?)?.toInt(),
      girlsCount: (json['girls_count'] as num?)?.toInt(),
      classId: json['class_id'] as String?,
      className: json['class_name'] as String?,
      division: json['division'] as String?,
      organizationId: json['organization_id'] as String?,
    );

Map<String, dynamic> _$DailyEntryModelToJson(DailyEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'boys_count': instance.boysCount,
      'girls_count': instance.girlsCount,
      'class_id': instance.classId,
      'class_name': instance.className,
      'division': instance.division,
      'organization_id': instance.organizationId,
    };
