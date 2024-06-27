import 'package:chss_noon_meal/data/model/config/class_list_model.dart';
import 'package:chss_noon_meal/domain/entity/config/class_data.dart';

extension ClassDataExtension on ClassListModel {
  ClassData toEntity() {
    return ClassData(
      classId: classId ?? '',
      className: name ?? '',
      divisions: divisions ?? List.empty(),
    );
  }
}

extension ClassDataListExtension on List<ClassListModel> {
  List<ClassData> toEntityList() {
    return map((e) => e.toEntity()).toList();
  }
}
