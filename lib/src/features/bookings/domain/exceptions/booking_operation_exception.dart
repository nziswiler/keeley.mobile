import 'package:keeley/src/common/exceptions/operation_exception.dart';

class BookingOperationException extends OperationException {
  const BookingOperationException(super.message, [super.details, super.cause]);
}
