import 'package:keeley/src/features/bookings/application/booking_service.dart';
import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';
import 'package:keeley/src/features/bookings/application/dtos/update_booking_dto.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:keeley/src/features/dashboard/application/dashboard_service.dart';

part 'edit_booking_controller.g.dart';

@riverpod
class EditBookingController extends _$EditBookingController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> createBooking(CreateBookingDto createBookingDto) async {
    state = const AsyncLoading();

    try {
      final bookingService = ref.read(bookingServiceProvider);
      await bookingService.createBooking(createBookingDto);
      state = const AsyncData(null);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateBooking(UpdateBookingDto updateBookingDto) async {
    state = const AsyncLoading();

    try {
      final bookingService = ref.read(bookingServiceProvider);
      await bookingService.updateBooking(updateBookingDto);
      state = const AsyncData(null);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> saveBooking({
    required DateTime date,
    required double amount,
    required BookingType type,
    required String description,
    required BookingCategory category,
    Booking? existingBooking,
  }) async {
    final bookingDto = CreateBookingDto(
      date: date,
      amount: amount,
      type: type,
      description: description,
      category: category,
    );

    if (existingBooking != null) {
      final updateDto = UpdateBookingDto(
        bookingId: existingBooking.id,
        bookingDto: bookingDto,
      );
      await updateBooking(updateDto);
    } else {
      await createBooking(bookingDto);
    }
    ref.invalidate(monthlyStatsProvider);
    ref.invalidate(categoryExpensesProvider);
  }
}
