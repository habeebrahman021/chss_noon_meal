import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

  // Convert the DateTime to a String in the specified format
  String toStringFormatted(String format) {
    final formatter = DateFormat(format);
    return formatter.format(this);
  }

  DateTime get firstDayOfMonth {
    return DateTime(year, month);
  }

  DateTime get lastDayOfMonth {
    final firstDayOfNextMonth =
        (month < 12) ? DateTime(year, month + 1) : DateTime(year + 1);
    return firstDayOfNextMonth.subtract(
      const Duration(days: 1),
    );
  }
}
