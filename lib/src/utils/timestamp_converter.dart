// lib/src/utils/timestamp_converter.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampConverter {
  /// Safely converts a Firestore value to DateTime
  static DateTime toDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    // Handle server timestamp that might not be resolved yet
    return DateTime.now();
  }

  /// Converts DateTime to Firestore Timestamp
  static Timestamp toTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }
}

extension DateTimeExtension on DateTime {
  Timestamp toTimestamp() => TimestampConverter.toTimestamp(this);
}
