import 'package:keeley/application/services/finance/booking_service.dart';
import 'package:keeley/data/repositories/repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Diese Datei sammelt und exportiert alle Service-Provider

// Provider für den TaskService
final bookingServiceProvider = Provider<BookingService>((ref) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return BookingService(bookingRepository);
});
