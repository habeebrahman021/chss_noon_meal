import 'package:cloud_firestore/cloud_firestore.dart';

extension DateTimeExtension on DateTime {
  Timestamp get timestamp {
    return Timestamp.fromDate(this);
  }

  // Get the start of the day as a Timestamp
  Timestamp get startOfDay {
    return Timestamp.fromDate(DateTime(year, month, day));
  }

  // Get the end of the day as a Timestamp
  Timestamp get endOfDay {
    return Timestamp.fromDate(
      DateTime(year, month, day, 23, 59, 59),
    );
  }
}
