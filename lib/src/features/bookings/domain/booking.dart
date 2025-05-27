import 'package:keeley/src/features/user_entity_base.dart';
import 'package:keeley/src/features/bookings/domain/booking_type.dart';

class Booking extends UserEntityBase {
  final DateTime date;
  final String? description;
  final double amount;
  final BookingType type;

  Booking({
    required String id,
    required this.date,
    required this.amount,
    required this.type,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'amount': amount,
      'type': type.value,
      'description': description,
    };
  }

  factory Booking.fromMap(Map<dynamic, dynamic> value, String id) {
    return Booking(
      id: id,
      date: DateTime.parse(value['date'] as String),
      amount: (value['amount'] as double).toDouble(),
      type: BookingType.values
          .firstWhere((type) => type.value == value['bookingType'] as int),
      description: value['description'] as String?,
    );
  }
}
