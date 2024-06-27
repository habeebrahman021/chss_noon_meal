import 'package:chss_noon_meal/data/model/config/class_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ConfigDataSource {
  Future<List<ClassListModel>> getClassList({
    required String organizationId,
  });
}

class DefaultConfigDataSource implements ConfigDataSource {
  DefaultConfigDataSource({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<List<ClassListModel>> getClassList({
    required String organizationId,
  }) async {
    final result = await firestore
        .collection('classes')
        .where('organization_id', isEqualTo: organizationId)
        .get();

    return result.docs.map((doc) {
      final data = doc.data();
      data['class_id'] = doc.id;
      return ClassListModel.fromJson(data);
    }).toList();
  }
}
