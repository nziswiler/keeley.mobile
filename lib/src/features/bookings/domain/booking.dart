import 'package:keeley/src/features/bookings/domain/booking_type.dart';
import 'package:keeley/src/features/user_entity_base.dart';
import 'package:keeley/src/utils/timestamp_converter.dart';

class Booking extends UserEntityBase {
  final double amount;
  final DateTime date;
  final BookingType type;
  final String? description;

  Booking({
    required String id,
    required String userId,
    required DateTime createdOn,
    required String createdBy,
    DateTime? modifiedOn,
    String? modifiedBy,
    required this.amount,
    required this.date,
    required this.type,
    this.description,
  }) {
    this.id = id;
    this.userId = userId;
    this.createdOn = createdOn;
    this.createdBy = createdBy;
    this.modifiedOn = modifiedOn;
    this.modifiedBy = modifiedBy;
  }

  factory Booking.fromMap(Map<String, dynamic> map, String documentId) {
    return Booking(
      id: documentId,
      userId: map['createdBy'] as String,
      createdOn: TimestampConverter.toDateTime(map['createdOn']),
      createdBy: map['createdBy'] as String,
      modifiedOn: map['updatedOn'] != null
          ? TimestampConverter.toDateTime(map['updatedOn'])
          : null,
      modifiedBy: map['updatedBy'] as String?,
      amount: (map['amount'] as num).toDouble(),
      date: TimestampConverter.toDateTime(map['date']),
      type: BookingType.fromValue(map['type']),
      description: map['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date.toTimestamp(), // Clean conversion
      'type': BookingType.fromValue(type.value).displayName,
      'description': description,
      if (modifiedOn != null) 'updatedOn': modifiedOn!.toTimestamp(),
      if (modifiedBy != null) 'updatedBy': modifiedBy,
    };
  }

  Booking copyWith({
    String? id,
    String? userId,
    DateTime? createdOn,
    String? createdBy,
    DateTime? modifiedOn,
    String? modifiedBy,
    double? amount,
    DateTime? date,
    BookingType? type,
    String? description,
  }) {
    return Booking(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdOn: createdOn ?? this.createdOn,
      createdBy: createdBy ?? this.createdBy,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }
}
