import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/auth/domain/exceptions/user_not_authenticated_exception.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/bookings/domain/repositories/i_booking_repository.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_repository.g.dart';

class BookingRepository implements IBookingRepository {
  const BookingRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String _bookingPath(String userId, String bookingId) =>
      '${Keys.usersCollection}/$userId/${Keys.bookingsCollection}/$bookingId';
  static String _bookingsPath(String userId) =>
      '${Keys.usersCollection}/$userId/${Keys.bookingsCollection}';

  @override
  Future<DocumentReference> addBooking({
    required String userId,
    required DateTime date,
    required double amount,
    required BookingType type,
    BookingCategory? category,
    String? description,
  }) =>
      _firestore.collection(_bookingsPath(userId)).add({
        Keys.firestoreDateField: Timestamp.fromDate(date),
        Keys.firestoreAmountField: amount,
        Keys.firestoreTypeField: type.value,
        Keys.firestoreCategoryField: category?.displayName,
        Keys.firestoreDescriptionField: description,
        Keys.createdOnField: FieldValue.serverTimestamp(),
        Keys.createdByField: userId,
      });

  @override
  Future<void> updateBooking({
    required String userId,
    required Booking booking,
  }) =>
      _firestore.doc(_bookingPath(userId, booking.id)).update({
        ...booking.toMap(),
        Keys.updatedOnField: FieldValue.serverTimestamp(),
        Keys.updatedByField: userId,
      });

  @override
  Future<void> deleteBooking({required String userId, required String id}) =>
      _firestore.doc(_bookingPath(userId, id)).delete();

  @override
  Query<Booking> queryBookings({required String userId}) => _firestore
      .collection(_bookingsPath(userId))
      .orderBy(Keys.firestoreDateField, descending: true)
      .withConverter(
        fromFirestore: (snapshot, _) =>
            Booking.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (booking, _) => booking.toMap(),
      );

  @override
  Future<List<Booking>> fetchBookings({required String userId}) async {
    final bookings = await queryBookings(userId: userId).get();
    return bookings.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<Booking?> getBooking({
    required String userId,
    required String bookingId,
  }) async {
    final doc = await _firestore.doc(_bookingPath(userId, bookingId)).get();
    if (!doc.exists || doc.data() == null) {
      return null;
    }
    return Booking.fromMap(doc.data()!, doc.id);
  }

  @override
  Future<List<Booking>> getBookingsInDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final snapshot = await _firestore
        .collection(_bookingsPath(userId))
        .where(Keys.firestoreDateField,
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where(Keys.firestoreDateField,
            isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .orderBy(Keys.firestoreDateField, descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Booking.fromMap(doc.data(), doc.id))
        .toList();
  }
}

@Riverpod(keepAlive: true)
BookingRepository bookingRepository(Ref ref) {
  return BookingRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Booking> bookingsQuery(Ref ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw UserNotAuthenticatedException();
  }
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.queryBookings(userId: user.uid);
}
