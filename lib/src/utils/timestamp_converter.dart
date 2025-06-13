import 'package:cloud_firestore/cloud_firestore.dart';

// This file provides utility functions to convert between Firestore Timestamps and Dart DateTime objects.
class TimestampConverter {
  static DateTime toDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;

    return DateTime.now();
  }

  static Timestamp toTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }
}

extension DateTimeExtension on DateTime {
  Timestamp toTimestamp() => TimestampConverter.toTimestamp(this);
}
