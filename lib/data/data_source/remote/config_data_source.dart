import 'package:chss_noon_meal/core/exceptions.dart';
import 'package:chss_noon_meal/data/model/config/class_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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
        .orderBy('name', descending: false)
        .get()
        .onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
      throw FailureException(error.toString());
    });

    return result.docs.map((doc) {
      final data = doc.data();
      data['class_id'] = doc.id;
      return ClassListModel.fromJson(data);
    }).toList();
  }
}
