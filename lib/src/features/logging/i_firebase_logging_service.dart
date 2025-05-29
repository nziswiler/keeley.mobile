abstract class IFirebaseLoggingService {
  Future<void> logBookingCreated({
    required String userId,
    required String bookingId,
    required String bookingType,
    required String category,
    required double amount,
  });

  Future<void> logBookingUpdated({
    required String userId,
    required String bookingId,
    required String bookingType,
    required String category,
    required double amount,
  });

  Future<void> logBookingDeleted({
    required String userId,
    required String bookingId,
  });
}
