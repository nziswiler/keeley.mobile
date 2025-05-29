import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/dismissible_booking_item.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/empty_state_widget.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/error_state_widget.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/loading_state_widget.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class BookingsListView extends ConsumerWidget {
  const BookingsListView({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsQuery = ref.watch(bookingsQueryProvider);

    return FirestoreListView<Booking>(
      key: const Key(Keys.bookingsListView),
      controller: scrollController,
      padding: const EdgeInsets.only(
        top: kToolbarHeight + Sizes.p16,
        left: Sizes.p16,
        right: Sizes.p16,
      ),
      query: bookingsQuery,
      emptyBuilder: (context) => const EmptyStateWidget(),
      errorBuilder: (context, error, stackTrace) =>
          ErrorStateWidget(error: error),
      loadingBuilder: (context) => const LoadingStateWidget(),
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
