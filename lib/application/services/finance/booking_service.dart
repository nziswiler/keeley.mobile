import 'package:keeley/domain/finance/model/booking.dart';
import 'package:keeley/domain/finance/objects/booking_type.dart';
import 'package:keeley/domain/finance/repository/booking_repository.dart';

class BookingService {
  final BookingRepository _bookingRepository;

  BookingService(this._bookingRepository);

  Future<List<Booking>> getBookings(String workspaceId) {
    return _bookingRepository.getBookings(workspaceId);
  }

  Future<Booking?> getBookingById(String workspaceId, String bookingId) {
    return _bookingRepository.getBookingById(workspaceId, bookingId);
  }

  Future<Booking> createBooking({
    required String workspaceId,
    required DateTime date,
    String? description,
    required double amount,
    required BookingType type,
    String? customerId,
    String? orderId,
    String? accountId,
    String? categoryId,
  }) {
    final booking = Booking();

    return _bookingRepository.saveBooking(booking);
  }

  Future<Booking> updateBooking(Booking booking) {
    return _bookingRepository.updateBooking(booking);
  }

  Future<void> deleteBooking(String workspaceId, String bookingId) {
    return _bookingRepository.deleteBooking(workspaceId, bookingId);
  }
}
