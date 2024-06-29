import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_entry_model.g.dart';

@JsonSerializable()
class DailyEntryModel {
  DailyEntryModel({
    this.id,
    this.date,
    this.boysCount,
    this.girlsCount,
    this.classId,
    this.className,
    this.division,
    this.organizationId,
  });

  factory DailyEntryModel.fromJson(Map<String, dynamic> json) =>
      _$DailyEntryModelFromJson(json);
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'date')
  final Timestamp? date;
  @JsonKey(name: 'boys_count')
  final int? boysCount;
  @JsonKey(name: 'girls_count')
  final int? girlsCount;
  @JsonKey(name: 'class_id')
  final String? classId;
  @JsonKey(name: 'class_name')
  final String? className;
  @JsonKey(name: 'division')
  final String? division;
  @JsonKey(name: 'organization_id')
  final String? organizationId;

  Map<String, dynamic> toJson() => _$DailyEntryModelToJson(this);
}
