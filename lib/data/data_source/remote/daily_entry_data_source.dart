import 'package:chss_noon_meal/data/model/daily_entry/daily_entry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DailyEntryDataSource {
  Future<List<DailyEntryModel>> getDailyEntries({
    required String date,
    required String organizationId,
  });
}

class DefaultDailyEntryDataSource implements DailyEntryDataSource {
  DefaultDailyEntryDataSource({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Future<List<DailyEntryModel>> getDailyEntries({
    required String date,
    required String organizationId,
  }) async {
    final result = await firestore
        .collection('daily_daily_entries')
        .where('date', isEqualTo: date)
        .where('organization_id', isEqualTo: organizationId)
        .get();

    return result.docs
        .map((doc) => DailyEntryModel.fromJson(doc.data()))
        .toList();
  }
}
