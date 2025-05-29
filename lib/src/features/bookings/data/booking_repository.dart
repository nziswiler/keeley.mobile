import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/bookings/domain/booking.dart';
import 'package:keeley/src/features/bookings/domain/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/booking_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_repository.g.dart';

class BookingRepository {
  const BookingRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String bookingPath(String userId, String bookingId) =>
      'users/$userId/bookings/$bookingId';
  static String bookingsPath(String userId) => 'users/$userId/bookings';

  Future<void> addBooking({
    required String userId,
    required DateTime date,
    required double amount,
    required BookingType type,
    BookingCategory? category,
    String? description,
  }) =>
      _firestore.collection(bookingsPath(userId)).add({
        'date': Timestamp.fromDate(date), // Convert DateTime to Timestamp
        'amount': amount,
        'type': type.value,
        'category': category?.displayName,
        'description': description,
        'createdOn': FieldValue.serverTimestamp(),
        'createdBy': userId,
      });

  Future<void> updateBooking({
    required String userId,
    required Booking booking,
  }) =>
      _firestore.doc(bookingPath(userId, booking.id)).update({
        ...booking.toMap(),
        'updatedOn': FieldValue.serverTimestamp(),
        'updatedBy': userId,
      });

  Future<void> deleteBooking({required String userId, required String id}) =>
      _firestore.doc(bookingPath(userId, id)).delete();

  Query<Booking> queryBookings({required String userId}) =>
      _firestore.collection(bookingsPath(userId)).withConverter(
            fromFirestore: (snapshot, _) =>
                Booking.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (booking, _) => booking.toMap(),
          );

  Future<List<Booking>> fetchBookings({required String userId}) async {
    final bookings = await queryBookings(userId: userId).get();
    return bookings.docs.map((doc) => doc.data()).toList();
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
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.queryBookings(userId: user.uid);
}
