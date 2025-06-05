import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';

class CreateBookingDto {
  const CreateBookingDto({
    required this.date,
    required this.amount,
    required this.type,
    required this.description,
    required this.category,
  });

  final DateTime date;
  final double amount;
  final BookingType type;
  final String description;
  final BookingCategory category;

  @override
  String toString() => 'EditBookingDto('
      'date: $date, '
      'amount: $amount, '
      'type: $type, '
      'description: $description, '
      'category: $category'
      ')';
}
