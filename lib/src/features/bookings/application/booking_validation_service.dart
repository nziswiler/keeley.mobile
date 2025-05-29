import 'package:keeley/src/features/bookings/application/dtos/update_booking_dto.dart';
import 'package:keeley/src/features/bookings/domain/exceptions/booking_validation_exeception.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';

class BookingValidationService {
  const BookingValidationService();

  void validateCreateCommand(CreateBookingDto createBookingDto) {
    final errors = <String>[];

    _validateAmount(createBookingDto.amount, errors);
    _validateDescription(createBookingDto.description, errors);
    _validateCategory(createBookingDto.type, createBookingDto.category, errors);

    if (errors.isNotEmpty) {
      throw BookingValidationException(
        'Create booking validation failed',
        errors,
      );
    }
  }

  void validateUpdateCommand(UpdateBookingDto updateBookingDto) {
    final errors = <String>[];

    _validateBookingId(updateBookingDto.bookingId, errors);
    final dto = updateBookingDto.bookingDto;
    _validateAmount(dto.amount, errors);
    _validateDescription(dto.description, errors);
    _validateCategory(dto.type, dto.category, errors);

    if (errors.isNotEmpty) {
      throw BookingValidationException(
        'Update booking validation failed',
        errors,
      );
    }
  }

  void _validateAmount(double amount, List<String> errors) {
    if (amount <= 0) {
      errors.add('Amount must be greater than zero');
    }
  }

  void _validateDescription(String description, List<String> errors) {
    if (description.trim().isEmpty) {
      errors.add('Description cannot be empty');
    }
  }

  void _validateBookingId(String bookingId, List<String> errors) {
    if (bookingId.trim().isEmpty) {
      errors.add('Booking ID cannot be empty');
    }
  }

  void _validateCategory(
    BookingType type,
    BookingCategory category,
    List<String> errors,
  ) {
    if (type == BookingType.income) {
      if (category != BookingCategory.salary &&
          category != BookingCategory.other) {
        errors.add(Strings.invalidCategoryForIncome);
      }
    } else if (type == BookingType.expense) {
      if (category == BookingCategory.salary) {
        errors.add(Strings.invalidCategoryForExpense);
      }
    }
  }
}
