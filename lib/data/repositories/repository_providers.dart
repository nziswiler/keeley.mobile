import 'package:keeley/data/repositories/finance/booking_repository.dart';
import 'package:keeley/domain/finance/repository/booking_repository.dart';
import 'package:riverpod/riverpod.dart';

/// Diese Datei sammelt und exportiert alle Repository-Providers

// Provider für BookingRepository
final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return MockBookingRepository();
});
