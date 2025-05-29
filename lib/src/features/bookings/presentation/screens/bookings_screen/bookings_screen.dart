import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/app_bar.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/bookings_controller.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/booking_card.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/edit_booking_screen.dart';
import 'package:keeley/src/utils/async_value_ui.dart';
import 'package:keeley/src/utils/alert_dialogs.dart';
import 'package:keeley/src/common/widgets/shad_floating_action_button.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      key: const Key(Keys.bookingsScreen),
      extendBodyBehindAppBar: true,
      appBar: ScrollableAppBar(
        title: Strings.bookings,
        scrollController: _scrollController,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            bookingsControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );
          final bookingsQuery = ref.watch(bookingsQueryProvider);
          return FirestoreListView<Booking>(
            key: const Key(Keys.bookingsListView),
            controller: _scrollController,
            padding: const EdgeInsets.only(
              top: kToolbarHeight +
                  Sizes.p16, // Platz für App Bar + zusätzlicher Abstand
              left: Sizes.p16,
              right: Sizes.p16,
            ),
            query: bookingsQuery,
            emptyBuilder: (context) => _buildEmptyState(context, theme),
            errorBuilder: (context, error, stackTrace) =>
                _buildErrorState(context, theme, error),
            loadingBuilder: (context) => _buildLoadingState(context, theme),
            itemBuilder: (context, snapshot) {
              final booking = snapshot.data();
              return Padding(
                padding: const EdgeInsets.only(bottom: Sizes.p12),
                child: _buildDismissibleBooking(context, ref, booking, theme),
              );
            },
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildEmptyState(BuildContext context, ShadThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: theme.colorScheme.mutedForeground,
          ),
          gapH16,
          Text(
            Strings.noBookingsFound,
            style: theme.textTheme.large.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
      BuildContext context, ShadThemeData theme, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.destructive,
          ),
          gapH16,
          Text(
            error.toString(),
            style: theme.textTheme.large.copyWith(
              color: theme.colorScheme.destructive,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context, ShadThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
              strokeWidth: 2,
            ),
          ),
          gapH16,
          Text(
            Strings.loading,
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissibleBooking(BuildContext context, WidgetRef ref,
      Booking booking, ShadThemeData theme) {
    return Dismissible(
      key: Key('${Keys.dismissibleBooking}-${booking.id}'),
      background: _buildEditBackground(theme),
      secondaryBackground: _buildDeleteBackground(theme),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Right to left swipe - delete
          return await _confirmDelete(context, theme);
        } else if (direction == DismissDirection.startToEnd) {
          // Left to right swipe - edit
          _showEditBookingModal(context, booking);
          return false; // Don't dismiss for edit
        }
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          ref.read(bookingsControllerProvider.notifier).deleteBooking(booking);
        }
      },
      child: BookingCard(booking: booking),
    );
  }

  Widget _buildEditBackground(ShadThemeData theme) {
    return Container(
      key: const Key(Keys.editBackground),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(Sizes.p12),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: Sizes.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_outlined,
            color: theme.colorScheme.primaryForeground,
            size: 24,
          ),
          gapH4,
          Text(
            Strings.editBooking,
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.primaryForeground,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteBackground(ShadThemeData theme) {
    return Container(
      key: const Key(Keys.deleteBackground),
      decoration: BoxDecoration(
        color: theme.colorScheme.destructive,
        borderRadius: BorderRadius.circular(Sizes.p12),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: Sizes.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_outline,
            color: theme.colorScheme.destructiveForeground,
            size: 24,
          ),
          gapH4,
          Text(
            Strings.deleteBooking,
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.destructiveForeground,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, ShadThemeData theme) {
    return showAlertDialog(
      context: context,
      title: Strings.confirmDelete,
      content: Strings.deleteBookingMessage,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.deleteBooking,
      isDestructive: true,
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ShadFloatingActionButton.add(
          key: const Key(Keys.floatingActionButton),
          onPressed: () => _showEditBookingModal(context),
          tooltip: Strings.newBooking,
        );
      },
    );
  }

  void _showEditBookingModal(BuildContext context, [Booking? booking]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => EditBookingScreen(booking: booking),
    );
  }
}
