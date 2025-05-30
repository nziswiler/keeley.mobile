import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';

abstract class IBookingRepository {
  Future<void> addBooking({
    required String userId,
    required DateTime date,
    required double amount,
    required BookingType type,
    BookingCategory? category,
    String? description,
  });

  Future<void> updateBooking({
    required String userId,
    required Booking booking,
  });

  Future<void> deleteBooking({
    required String userId,
    required String id,
  });

  Query<Booking> queryBookings({required String userId});

  Future<List<Booking>> fetchBookings({required String userId});

  Future<Booking?> getBooking({
    required String userId,
    required String bookingId,
  });

  Future<List<Booking>> getBookingsInDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  });
}
