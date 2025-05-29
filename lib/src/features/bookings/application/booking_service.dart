import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/auth/domain/exceptions/user_not_authenticated_exception.dart';
import 'package:keeley/src/features/bookings/application/dtos/update_booking_dto.dart';
import 'package:keeley/src/features/bookings/domain/exceptions/booking_operation_exception.dart';
import 'package:keeley/src/features/bookings/domain/repositories/i_booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/services/i_booking_service.dart';
import 'package:keeley/src/features/bookings/application/booking_validation_service.dart';
import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_service.g.dart';

class BookingService implements IBookingService {
  const BookingService({
    required this.bookingRepository,
    required this.validationService,
    required this.authRepository,
  });

  final IBookingRepository bookingRepository;
  final BookingValidationService validationService;
  final AuthRepository authRepository;

  @override
  Future<void> createBooking(CreateBookingDto createBookingDto) async {
    final currentUser = _getCurrentUser();
    validationService.validateCreateCommand(createBookingDto);

    try {
      await bookingRepository.addBooking(
        userId: currentUser.uid,
        date: createBookingDto.date,
        amount: createBookingDto.amount,
        type: createBookingDto.type,
        category: createBookingDto.category,
        description: createBookingDto.description,
      );
    } on Exception catch (e) {
      throw BookingOperationException(
        'Failed to create booking',
        e.toString(),
        e,
      );
    }
  }

  @override
  Future<void> updateBooking(UpdateBookingDto updateBookingDto) async {
    final currentUser = _getCurrentUser();
    validationService.validateUpdateCommand(updateBookingDto);

    try {
      final existingBooking = await bookingRepository.getBooking(
        userId: currentUser.uid,
        bookingId: updateBookingDto.bookingId,
      );

      if (existingBooking == null) {
        throw BookingOperationException(
          'Booking not found',
          'Booking with ID ${updateBookingDto.bookingId} not found',
        );
      }

      final dto = updateBookingDto.bookingDto;
      final updatedBooking = existingBooking.copyWith(
        amount: dto.amount,
        date: dto.date,
        type: dto.type,
        category: dto.category,
        description: dto.description,
        modifiedOn: DateTime.now(),
        modifiedBy: currentUser.uid,
      );

      await bookingRepository.updateBooking(
        userId: currentUser.uid,
        booking: updatedBooking,
      );
    } catch (e) {
      throw BookingOperationException(
        'Failed to update booking',
        e.toString(),
      );
    }
  }

  @override
  Future<void> deleteBooking(String bookingId) async {
    final currentUser = _getCurrentUser();

    try {
      await bookingRepository.deleteBooking(
        userId: currentUser.uid,
        id: bookingId,
      );
    } on Exception catch (e) {
      throw BookingOperationException(
        'Failed to delete booking',
        e.toString(),
        e,
      );
    }
  }

  _getCurrentUser() {
    final currentUser = authRepository.currentUser;
    if (currentUser == null) {
      throw const UserNotAuthenticatedException();
    }
    return currentUser;
  }
}

@riverpod
BookingValidationService bookingValidationService(ref) {
  return const BookingValidationService();
}

@riverpod
BookingService bookingService(ref) {
  return BookingService(
    bookingRepository: ref.read(bookingRepositoryProvider),
    validationService: ref.read(bookingValidationServiceProvider),
    authRepository: ref.read(authRepositoryProvider),
  );
}
