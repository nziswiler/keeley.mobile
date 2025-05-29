import 'package:keeley/src/features/bookings/application/booking_service.dart';
import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';
import 'package:keeley/src/features/bookings/application/dtos/update_booking_dto.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/common/widgets/loading_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_booking_controller.g.dart';

@riverpod
class EditBookingController extends _$EditBookingController {
  @override
  LoadingState<void> build() {
    return LoadingState.initial();
  }

  Future<void> createBooking(CreateBookingDto createBookingDto) async {
    state = LoadingState.loading();

    try {
      final bookingService = ref.read(bookingServiceProvider);
      await bookingService.createBooking(createBookingDto);
      state = LoadingState.success(null);
    } on Exception catch (e) {
      state = LoadingState.error(e);
    }
  }

  Future<void> updateBooking(UpdateBookingDto updateBookingDto) async {
    state = LoadingState.loading();

    try {
      final bookingService = ref.read(bookingServiceProvider);
      await bookingService.updateBooking(updateBookingDto);
      state = LoadingState.success(null);
    } on Exception catch (e) {
      state = LoadingState.error(e);
    }
  }

  Future<void> saveBooking({
    required DateTime date,
    required double amount,
    required type,
    required String description,
    required category,
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
      final createDto = CreateBookingDto(
        date: bookingDto.date,
        amount: bookingDto.amount,
        type: bookingDto.type,
        description: bookingDto.description,
        category: bookingDto.category,
      );
      final updateDto = UpdateBookingDto(
        bookingId: existingBooking.id,
        bookingDto: createDto,
      );
      await updateBooking(updateDto);
    } else {
      final createDto = CreateBookingDto(
        date: bookingDto.date,
        amount: bookingDto.amount,
        type: bookingDto.type,
        description: bookingDto.description,
        category: bookingDto.category,
      );
      await createBooking(createDto);
    }
  }
}
