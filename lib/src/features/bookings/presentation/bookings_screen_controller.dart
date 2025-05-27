import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/booking.dart';
import 'package:keeley/src/features/bookings/domain/booking_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_screen_controller.g.dart';

@riverpod
class BookingsScreenController extends _$BookingsScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteBooking(Booking booking) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(bookingRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        repository.deleteBooking(userId: currentUser.uid, id: booking.id));
  }

  Future<void> createBooking() async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(bookingRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.addBooking(
          userId: currentUser.uid,
          date: DateTime.now(),
          amount: 100,
          type: BookingType.income,
          description: "Hoi",
        ));
  }
}
