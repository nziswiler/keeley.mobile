import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';

class UpdateBookingDto {
  const UpdateBookingDto({
    required this.bookingId,
    required this.bookingDto,
  });

  final String bookingId;
  final CreateBookingDto bookingDto;

  @override
  String toString() => 'UpdateBookingCommand('
      'bookingId: $bookingId, '
      'bookingDto: $bookingDto'
      ')';
}
