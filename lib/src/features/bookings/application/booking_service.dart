import 'package:keeley/src/features/logging/firebase_logging_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/auth/domain/exceptions/user_not_authenticated_exception.dart';
import 'package:keeley/src/features/bookings/application/dtos/update_booking_dto.dart';
import 'package:keeley/src/features/bookings/domain/exceptions/booking_operation_exception.dart';
import 'package:keeley/src/features/bookings/domain/repositories/i_booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/services/i_booking_service.dart';
import 'package:keeley/src/features/bookings/application/booking_validation_service.dart';
import 'package:keeley/src/features/bookings/application/dtos/create_booking_dto.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_service.g.dart';

class BookingService implements IBookingService {
  const BookingService({
    required this.bookingRepository,
    required this.validationService,
    required this.authRepository,
    required this.loggingService,
  });

  final IBookingRepository bookingRepository;
  final BookingValidationService validationService;
  final AuthRepository authRepository;
  final FirebaseLoggingService loggingService;

  @override
  Future<void> createBooking(CreateBookingDto createBookingDto) async {
    final currentUser = _getCurrentUser();
    validationService.validateCreateCommand(createBookingDto);

    try {
      final docRef = await bookingRepository.addBooking(
        userId: currentUser.uid,
        date: createBookingDto.date,
        amount: createBookingDto.amount,
        type: createBookingDto.type,
        category: createBookingDto.category,
        description: createBookingDto.description,
      );

      await loggingService.logBookingCreated(
        userId: currentUser.uid,
        bookingId: docRef.id,
        bookingType: createBookingDto.type.value.toString(),
        category: createBookingDto.category.displayName,
        amount: createBookingDto.amount,
      );
    } on Exception catch (e) {
      throw BookingOperationException(
        Strings.failedToCreateBooking,
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
          Strings.bookingNotFound,
          Strings.bookingNotFoundMessage
              .replaceAll('{0}', updateBookingDto.bookingId),
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

      await loggingService.logBookingUpdated(
        userId: currentUser.uid,
        bookingId: updateBookingDto.bookingId,
        bookingType: dto.type.value.toString(),
        category: dto.category.displayName,
        amount: dto.amount,
      );
    } catch (e) {
      throw BookingOperationException(
        Strings.failedToUpdateBooking,
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

      await loggingService.logBookingDeleted(
        userId: currentUser.uid,
        bookingId: bookingId,
      );
    } on Exception catch (e) {
      throw BookingOperationException(
        Strings.failedToDeleteBooking,
        e.toString(),
        e,
      );
    }
  }

  User _getCurrentUser() {
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
    loggingService: ref.read(firebaseLoggingServiceProvider),
  );
}
