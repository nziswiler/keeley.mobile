import 'package:keeley/src/features/bookings/application/booking_service.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_controller.g.dart';

@riverpod
class BookingsController extends _$BookingsController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteBooking(Booking booking) async {
    state = const AsyncLoading();

    try {
      final bookingService = ref.read(bookingServiceProvider);

      state = await AsyncValue.guard(
          () => bookingService.deleteBooking(booking.id));
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
