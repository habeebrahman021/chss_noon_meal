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
}

class DefaultDailyEntryDataSource implements DailyEntryDataSource {
  DefaultDailyEntryDataSource({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<List<DailyEntryModel>> getDailyEntriesByDate({
    required DateTime date,
    required String organizationId,
  }) async {
    final result = await firestore
        .collection('daily_daily_entries')
        .where('date', isGreaterThanOrEqualTo: date.startOfDay)
        .where('date', isLessThanOrEqualTo: date.endOfDay)
        .where('organization_id', isEqualTo: organizationId)
        .get();

    return result.docs
        .map((doc) => DailyEntryModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<DailyEntryModel>> getDailyEntriesByDateRange({
    required Timestamp fromDate,
    required Timestamp toDate,
    required String organizationId,
  }) async {
    final result = await firestore
        .collection('daily_daily_entries')
        .where('date', isGreaterThanOrEqualTo: fromDate)
        .where('date', isLessThanOrEqualTo: toDate)
        .where('organization_id', isEqualTo: organizationId)
        .get();

    return result.docs
        .map((doc) => DailyEntryModel.fromJson(doc.data()))
        .toList();
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
    final result = await firestore.collection('daily_daily_entries').add({
      'date': date,
      'boys_count': boysCount,
      'girls_count': girlsCount,
      'class_id': classId,
      'class_name': className,
      'division': division,
      'organization_id': organizationId,
    }).onError((error, stackTrace) {
      throw FailureException('Error saving daily entry: $error');
    });
    return result.id;
  }
}
