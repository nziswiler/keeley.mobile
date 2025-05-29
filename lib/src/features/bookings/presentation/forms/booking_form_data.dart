import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';

class BookingFormData {
  const BookingFormData({
    required this.date,
    required this.amount,
    required this.type,
    required this.description,
    required this.category,
  });

  factory BookingFormData.fromBooking(Booking booking) {
    return BookingFormData(
      date: booking.date,
      amount: booking.amount,
      type: booking.type,
      description: booking.description ?? '',
      category: booking.category ?? BookingCategory.other,
    );
  }

  final DateTime date;
  final double amount;
  final BookingType type;
  final String description;
  final BookingCategory category;

  BookingFormData copyWith({
    DateTime? date,
    double? amount,
    BookingType? type,
    String? description,
    BookingCategory? category,
  }) {
    return BookingFormData(
      date: date ?? this.date,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  CreateBookingDto toBookingDto() {
    return CreateBookingDto(
      date: date,
      amount: amount,
      type: type,
      description: description,
      category: category,
    );
  }

  List<String> validate() {
    final errors = <String>[];

    // Amount validation
    if (amount <= 0) {
      errors.add('Amount must be greater than zero');
    }

    if (description.trim().isEmpty) {
      errors.add('Description cannot be empty');
    }

    if (type == BookingType.income) {
      if (category != BookingCategory.salary &&
          category != BookingCategory.other) {
        errors.add('For income, only salary and other categories are allowed');
      }
    } else if (type == BookingType.expense) {
      if (category == BookingCategory.salary) {
        errors.add('Salary category is not allowed for expenses');
      }
    }

    return errors;
  }

  bool get isValid => validate().isEmpty;
}
