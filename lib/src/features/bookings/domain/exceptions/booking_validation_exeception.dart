import 'package:keeley/src/common/exceptions/validation_exception.dart';

class BookingValidationException extends ValidationException {
  const BookingValidationException(super.message, super.errors);
}
