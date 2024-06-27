import 'package:json_annotation/json_annotation.dart';

part 'class_list_model.g.dart';

@JsonSerializable()
class ClassListModel {
  ClassListModel({
    this.classId,
    this.name,
    this.divisions,
    this.organizationId,
  });

  factory ClassListModel.fromJson(Map<String, dynamic> json) =>
      _$ClassListModelFromJson(json);
  @JsonKey(name: 'class_id')
  final String? classId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'divisions')
  final List<String>? divisions;
  @JsonKey(name: 'organization_id')
  final String? organizationId;

  Map<String, dynamic> toJson() => _$ClassListModelToJson(this);
}
