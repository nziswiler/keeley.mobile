import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/empty_state_card.dart';
import 'package:keeley/src/common/widgets/error_card.dart';
import 'package:keeley/src/common/widgets/loading_card.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/dismissible_booking_item.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class BookingsListView extends ConsumerWidget {
  const BookingsListView({
    super.key,
    required this.scrollController,
    required this.padding,
  });

  final ScrollController scrollController;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsQuery = ref.watch(bookingsQueryProvider);

    return FirestoreListView<Booking>(
      key: const Key(Keys.bookingsListView),
      controller: scrollController,
      padding: padding,
      query: bookingsQuery,
      emptyBuilder: (context) => Padding(
        padding: padding,
        child: const EmptyStateCard(
          icon: Icons.account_balance_wallet_outlined,
          emptyTitle: Strings.noBookingsTitle,
          emptyMessage: Strings.noBookingsMessage,
        ),
      ),
      errorBuilder: (context, error, stackTrace) => Padding(
        padding: padding,
        child: ErrorCard(
          error: error,
          errorTitle: Strings.bookingsLoadingError,
        ),
      ),
      loadingBuilder: (context) => Padding(
        padding: padding,
        child: const LoadingCard(
          loadingText: Strings.loadingBookings,
        ),
      ),
      itemBuilder: (context, snapshot) {
        final booking = snapshot.data();
        return Padding(
          padding: const EdgeInsets.only(bottom: Sizes.p12),
          child: DismissibleBookingItem(booking: booking),
        );
      },
    );
  }
}
