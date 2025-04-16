import 'package:keeley/application/services/service_providers.dart';
import 'package:keeley/presentation/controllers/finance/booking_controller.dart';
import 'package:riverpod/riverpod.dart';

final bookingControllerProvider =
    StateNotifierProvider.family<BookingController, BookingState, String>(
  (ref, workspaceId) {
    final bookingService = ref.watch(bookingServiceProvider);
    return BookingController(bookingService, workspaceId);
  },
);
