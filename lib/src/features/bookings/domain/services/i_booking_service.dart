import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';
import 'package:keeley/src/features/bookings/application/dtos/update_booking_dto.dart';

abstract class IBookingService {
  /// Throws [BookingValidationException] if validation fails
  /// Throws [UserNotAuthenticatedException] if user is not authenticated
  /// Throws [BookingOperationException] if operation fails
  Future<void> createBooking(CreateBookingDto createBookingDto);

  /// Throws [BookingValidationException] if validation fails
  /// Throws [UserNotAuthenticatedException] if user is not authenticated
  /// Throws [BookingOperationException] if operation fails
  Future<void> updateBooking(UpdateBookingDto updateBookingDto);

  /// Throws [UserNotAuthenticatedException] if user is not authenticated
  /// Throws [BookingOperationException] if operation fails
  Future<void> deleteBooking(String bookingId);
}
