import 'package:chss_noon_meal/core/exceptions.dart';
import 'package:chss_noon_meal/core/extension/date_time_extension.dart';
import 'package:chss_noon_meal/data/model/daily_entry/daily_entry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DailyEntryDataSource {
  Future<List<DailyEntryModel>> getDailyEntriesByDate({
    required DateTime date,
    required String organizationId,
  });

  Future<List<DailyEntryModel>> getDailyEntriesByDateRange({
    required Timestamp fromDate,
    required Timestamp toDate,
    required String organizationId,
  });

  Future<String> saveDailyEntries({
    required Timestamp date,
    required int boysCount,
    required int girlsCount,
    required String classId,
    required String className,
    required String division,
    required String organizationId,
  });

  Future<List<DailyEntryModel>> getDailyEntryByDateAndClass({
    required DateTime date,
    required String classId,
    required String division,
    required String organizationId,
  });

  Future<String> updateDailyEntries({
    required String id,
    required int boysCount,
    required int girlsCount,
  });
}

class DefaultDailyEntryDataSource implements DailyEntryDataSource {
  DefaultDailyEntryDataSource({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  static const collectionName = 'daily_student_entries';
  static const dateFieldName = 'date';
  static const boysCountFieldName = 'boys_count';
  static const girlsCountFieldName = 'girls_count';
  static const classIdFieldName = 'class_id';
  static const classNameFieldName = 'class_name';
  static const divisionFieldName = 'division';
  static const organizationIdFieldName = 'organization_id';

  @override
  Future<List<DailyEntryModel>> getDailyEntriesByDate({
    required DateTime date,
    required String organizationId,
  }) async {
    final result = await firestore
        .collection(collectionName)
        .where(dateFieldName, isGreaterThanOrEqualTo: date.startOfDay)
        .where(dateFieldName, isLessThanOrEqualTo: date.endOfDay)
        .where(organizationIdFieldName, isEqualTo: organizationId)
        .get();

    return result.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return DailyEntryModel.fromJson(data);
    }).toList();
  }

  @override
  Future<List<DailyEntryModel>> getDailyEntriesByDateRange({
    required Timestamp fromDate,
    required Timestamp toDate,
    required String organizationId,
  }) async {
    final result = await firestore
        .collection(collectionName)
        .where(dateFieldName, isGreaterThanOrEqualTo: fromDate)
        .where(dateFieldName, isLessThanOrEqualTo: toDate)
        .where(organizationIdFieldName, isEqualTo: organizationId)
        .get();

    return result.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return DailyEntryModel.fromJson(data);
    }).toList();
  }

  @override
  Future<String> saveDailyEntries({
    required Timestamp date,
    required int boysCount,
    required int girlsCount,
    required String classId,
    required String className,
    required String division,
    required String organizationId,
  }) async {
    final result = await firestore.collection(collectionName).add({
      dateFieldName: date,
      boysCountFieldName: boysCount,
      girlsCountFieldName: girlsCount,
      classIdFieldName: classId,
      classNameFieldName: className,
      divisionFieldName: division,
      organizationIdFieldName: organizationId,
    }).onError((error, stackTrace) {
      throw FailureException('Error saving daily entry: $error');
    });
    return result.id;
  }

  @override
  Future<List<DailyEntryModel>> getDailyEntryByDateAndClass({
    required DateTime date,
    required String classId,
    required String division,
    required String organizationId,
  }) async {
    final result = await firestore
        .collection(collectionName)
        .where(dateFieldName, isGreaterThanOrEqualTo: date.startOfDay)
        .where(dateFieldName, isLessThanOrEqualTo: date.endOfDay)
        .where(classIdFieldName, isEqualTo: classId)
        .where(divisionFieldName, isEqualTo: division)
        .where(organizationIdFieldName, isEqualTo: organizationId)
        .get();

    return result.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return DailyEntryModel.fromJson(data);
    }).toList();
  }

  @override
  Future<String> updateDailyEntries({
    required String id,
    required int boysCount,
    required int girlsCount,
  }) async {
    await firestore.collection(collectionName).doc(id).update({
      boysCountFieldName: boysCount,
      girlsCountFieldName: girlsCount,
    }).onError((error, stackTrace) {
      throw FailureException('Error saving updating entry: $error');
    });
    return id;
  }
}
