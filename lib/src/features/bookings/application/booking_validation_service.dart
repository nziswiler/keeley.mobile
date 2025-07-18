import 'package:keeley/src/features/bookings/application/dtos/update_booking_dto.dart';
import 'package:keeley/src/features/bookings/domain/exceptions/booking_validation_exeception.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';
import 'package:keeley/src/features/bookings/domain/services/i_booking_validation_service.dart';

class BookingValidationService implements IBookingValidationService {
  const BookingValidationService();

  @override
  void validateCreateCommand(CreateBookingDto createBookingDto) {
    final errors = <String>[];

    _validateAmount(createBookingDto.amount, errors);
    _validateDescription(createBookingDto.description, errors);
    _validateCategory(createBookingDto.type, createBookingDto.category, errors);

    if (errors.isNotEmpty) {
      throw BookingValidationException(
        Strings.bookingValidationFailed,
        errors,
      );
    }
  }

  @override
  void validateUpdateCommand(UpdateBookingDto updateBookingDto) {
    final errors = <String>[];

    _validateBookingId(updateBookingDto.bookingId, errors);
    final dto = updateBookingDto.bookingDto;
    _validateAmount(dto.amount, errors);
    _validateDescription(dto.description, errors);
    _validateCategory(dto.type, dto.category, errors);

    if (errors.isNotEmpty) {
      throw BookingValidationException(
        Strings.bookingValidationFailed,
        errors,
      );
    }
  }

  void _validateAmount(double amount, List<String> errors) {
    if (amount <= 0) {
      errors.add(Strings.amountGreaterThanZero);
    }
  }

  void _validateDescription(String description, List<String> errors) {
    if (description.trim().isEmpty) {
      errors.add(Strings.descriptionCannotBeEmpty);
    }
  }

  void _validateBookingId(String bookingId, List<String> errors) {
    if (bookingId.trim().isEmpty) {
      errors.add(Strings.bookingIdCannotBeEmpty);
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
