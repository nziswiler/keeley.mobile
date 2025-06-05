import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/user_entity_base.dart';
import 'package:keeley/src/utils/timestamp_converter.dart';
import 'package:keeley/src/constants/keys.dart';

class Booking extends UserEntityBase {
  final double amount;
  final DateTime date;
  final BookingType type;
  final BookingCategory? category;
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
    this.category,
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
      userId: map[Keys.createdByField] as String,
      createdOn: TimestampConverter.toDateTime(map[Keys.createdOnField]),
      createdBy: map[Keys.createdByField] as String,
      modifiedOn: map[Keys.updatedOnField] != null
          ? TimestampConverter.toDateTime(map[Keys.updatedOnField])
          : null,
      modifiedBy: map[Keys.updatedByField] as String?,
      amount: (map[Keys.firestoreAmountField] as num?)?.toDouble() ?? 0.0,
      date: TimestampConverter.toDateTime(map[Keys.firestoreDateField]),
      type: BookingType.fromValue(map[Keys.firestoreTypeField]),
      category: map[Keys.firestoreCategoryField] != null
          ? BookingCategory.fromString(
              map[Keys.firestoreCategoryField] as String)
          : null,
      description: map[Keys.firestoreDescriptionField] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Keys.firestoreAmountField: amount,
      Keys.firestoreDateField: date.toTimestamp(),
      Keys.firestoreTypeField: type.value,
      Keys.firestoreCategoryField: category?.displayName,
      Keys.firestoreDescriptionField: description,
      if (modifiedOn != null) Keys.updatedOnField: modifiedOn!.toTimestamp(),
      if (modifiedBy != null) Keys.updatedByField: modifiedBy,
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
    BookingCategory? category,
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
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }
}
