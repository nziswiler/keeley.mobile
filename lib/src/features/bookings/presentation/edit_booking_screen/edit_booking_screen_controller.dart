import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/booking.dart';
import 'package:keeley/src/features/bookings/domain/booking_type.dart';
import 'package:keeley/src/common_widgets/loading_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_booking_screen_controller.g.dart';

@riverpod
class EditBookingScreenController extends _$EditBookingScreenController {
  @override
  LoadingState<void> build() {
    return LoadingState.initial();
  }

  Future<void> saveBooking({
    required DateTime date,
    required double? amount,
    required BookingType type,
    required String description,
    String? category,
    Booking? existingBooking,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }

    if (amount == null || amount <= 0) {
      throw ArgumentError('Amount must be greater than zero');
    }

    final repository = ref.read(bookingRepositoryProvider);
    state = LoadingState.loading();

    try {
      if (existingBooking != null) {
        final updatedBooking = Booking(
          id: existingBooking.id,
          userId: existingBooking.userId,
          createdOn: existingBooking.createdOn,
          createdBy: existingBooking.createdBy,
          modifiedOn: DateTime.now(),
          modifiedBy: currentUser.uid,
          amount: amount,
          date: date,
          type: type,
          description: description,
        );
        await repository.updateBooking(
          userId: currentUser.uid,
          booking: updatedBooking,
        );
      } else {
        await repository.addBooking(
          userId: currentUser.uid,
          date: date,
          amount: amount,
          type: type,
          description: description,
        );
      }
      state = LoadingState.success(null);
    } on Exception catch (e) {
      state = LoadingState.error(e);
    }
  }
}
