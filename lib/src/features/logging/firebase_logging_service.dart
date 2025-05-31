// firebase_logging_service.dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:keeley/src/features/logging/i_firebase_logging_service.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_logging_service.g.dart';

class FirebaseLoggingService implements IFirebaseLoggingService {
  const FirebaseLoggingService({
    required this.analytics,
  });

  final FirebaseAnalytics analytics;

  @override
  Future<void> logBookingCreated({
    required String userId,
    required String bookingId,
    required String bookingType,
    required String category,
    required double amount,
  }) async {
    try {
      await analytics.logEvent(
        name: Keys.bookingCreatedEvent,
        parameters: {
          Keys.userIdParam: userId,
          Keys.bookingIdParam: bookingId,
          Keys.bookingTypeParam: bookingType,
          Keys.categoryParam: category,
          Keys.amountParam: amount,
          Keys.timestampParam: DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      throw Exception(
          Strings.failedToLogBookingCreation.replaceAll('{0}', e.toString()));
    }
  }

  @override
  Future<void> logBookingUpdated({
    required String userId,
    required String bookingId,
    required String bookingType,
    required String category,
    required double amount,
  }) async {
    try {
      await analytics.logEvent(
        name: Keys.bookingUpdatedEvent,
        parameters: {
          Keys.userIdParam: userId,
          Keys.bookingIdParam: bookingId,
          Keys.bookingTypeParam: bookingType,
          Keys.categoryParam: category,
          Keys.amountParam: amount,
          Keys.timestampParam: DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      throw Exception(
          Strings.failedToLogBookingUpdate.replaceAll('{0}', e.toString()));
    }
  }

  @override
  Future<void> logBookingDeleted({
    required String userId,
    required String bookingId,
  }) async {
    try {
      await analytics.logEvent(
        name: Keys.bookingDeletedEvent,
        parameters: {
          Keys.userIdParam: userId,
          Keys.bookingIdParam: bookingId,
          Keys.timestampParam: DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      throw Exception(
          Strings.failedToLogBookingDeletion.replaceAll('{0}', e.toString()));
    }
  }
}

@riverpod
FirebaseAnalytics firebaseAnalytics(ref) {
  return FirebaseAnalytics.instance;
}

@riverpod
FirebaseLoggingService firebaseLoggingService(ref) {
  return FirebaseLoggingService(
    analytics: ref.read(firebaseAnalyticsProvider),
  );
}
