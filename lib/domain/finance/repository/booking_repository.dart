import 'package:keeley/domain/finance/model/booking.dart';

abstract class BookingRepository {
  /// Lädt alle Buchungen für einen bestimmten Workspace
  Future<List<Booking>> getBookings(String workspaceId);

  /// Lädt eine spezifische Buchung anhand ihrer ID
  Future<Booking?> getBookingById(String workspaceId, String bookingId);

  /// Speichert eine neue Buchung
  Future<Booking> saveBooking(Booking booking);

  /// Aktualisiert eine bestehende Buchung
  Future<Booking> updateBooking(Booking booking);

  /// Löscht eine Buchung anhand ihrer ID
  Future<void> deleteBooking(String workspaceId, String bookingId);
}
