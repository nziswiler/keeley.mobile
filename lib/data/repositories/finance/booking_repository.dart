import 'package:keeley/domain/finance/model/booking.dart';
import 'package:keeley/domain/finance/repository/booking_repository.dart';

/// Eine Mock-Implementierung des BookingRepository.
class MockBookingRepository implements BookingRepository {
  final Map<String, List<Booking>> _bookingsMap = {};

  @override
  Future<List<Booking>> getBookings(String workspaceId) async {
    return _bookingsMap[workspaceId] ?? [];
  }

  @override
  Future<Booking?> getBookingById(String workspaceId, String bookingId) async {
    final bookings = _bookingsMap[workspaceId] ?? [];
    return bookings.firstWhere(
      (booking) => booking.id == bookingId,
      orElse: () => throw Exception('Buchung nicht gefunden'),
    );
  }

  @override
  Future<Booking> saveBooking(Booking booking) async {
    _bookingsMap.putIfAbsent(booking.workspaceId, () => []);
    _bookingsMap[booking.workspaceId]!.add(booking);

    return booking;
  }

  @override
  Future<Booking> updateBooking(Booking booking) async {
    final bookings = _bookingsMap[booking.workspaceId] ?? [];
    final index = bookings.indexWhere((b) => b.id == booking.id);

    if (index >= 0) {
      bookings[index] = booking;
      return booking;
    } else {
      throw Exception('Buchung nicht gefunden');
    }
  }

  @override
  Future<void> deleteBooking(String workspaceId, String bookingId) async {
    final bookings = _bookingsMap[workspaceId] ?? [];
    final index = bookings.indexWhere((booking) => booking.id == bookingId);

    if (index >= 0) {
      bookings.removeAt(index);
    } else {
      throw Exception('Buchung nicht gefunden');
    }
  }
}
