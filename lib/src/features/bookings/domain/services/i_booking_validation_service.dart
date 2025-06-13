import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';
import 'package:keeley/src/features/bookings/application/dtos/update_booking_dto.dart';

abstract class IBookingValidationService {
  void validateCreateCommand(CreateBookingDto createBookingDto);

  void validateUpdateCommand(UpdateBookingDto updateBookingDto);
}
