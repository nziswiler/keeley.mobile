import 'package:keeley/application/services/finance/booking_service.dart';
import 'package:keeley/domain/finance/model/booking.dart';
import 'package:keeley/domain/finance/objects/booking_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingState {
  final List<Booking> bookings;
  final bool isLoading;
  final String? errorMessage;
  final double totalIncome;
  final double totalExpenses;
  final double balance;

  BookingState({
    this.bookings = const [],
    this.isLoading = false,
    this.errorMessage,
    this.totalIncome = 0.0,
    this.totalExpenses = 0.0,
    this.balance = 0.0,
  });

  BookingState copyWith({
    List<Booking>? bookings,
    bool? isLoading,
    String? errorMessage,
    double? totalIncome,
    double? totalExpenses,
    double? balance,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      balance: balance ?? this.balance,
    );
  }
}

class BookingController extends StateNotifier<BookingState> {
  final BookingService _bookingService;
  final String _workspaceId;

  BookingController(this._bookingService, this._workspaceId)
      : super(BookingState());

  Future<void> loadBookings() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final bookings = await _bookingService.getBookings(_workspaceId);
      state = state.copyWith(
        bookings: bookings,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Fehler beim Laden der Buchungen: ${e.toString()}',
      );
    }
  }

  Future<Booking?> getBookingById(String bookingId) async {
    try {
      return await _bookingService.getBookingById(_workspaceId, bookingId);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Fehler beim Laden der Buchung: ${e.toString()}',
      );
      return null;
    }
  }

  Future<Booking?> createBooking({
    required DateTime date,
    String? description,
    required double amount,
    required BookingType type,
    String? customerId,
    String? orderId,
    String? accountId,
    String? categoryId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final booking = await _bookingService.createBooking(
        workspaceId: _workspaceId,
        date: date,
        description: description,
        amount: amount,
        type: type,
        customerId: customerId,
        orderId: orderId,
        accountId: accountId,
        categoryId: categoryId,
      );

      await loadBookings();
      return booking;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Fehler beim Erstellen der Buchung: ${e.toString()}',
      );
      return null;
    }
  }

  Future<bool> updateBooking(Booking booking) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _bookingService.updateBooking(booking);
      await loadBookings();
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Fehler beim Aktualisieren der Buchung: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> deleteBooking(String bookingId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _bookingService.deleteBooking(_workspaceId, bookingId);
      await loadBookings();
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Fehler beim Löschen der Buchung: ${e.toString()}',
      );
      return false;
    }
  }
}
