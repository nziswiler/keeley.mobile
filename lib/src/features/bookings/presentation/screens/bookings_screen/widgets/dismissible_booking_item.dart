import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/bookings_controller.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/booking_card.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/edit_booking_screen.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/dialogs.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DismissibleBookingItem extends ConsumerWidget {
  const DismissibleBookingItem({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    return Dismissible(
      key: Key('${Keys.dismissibleBooking}-${booking.id}'),
      background: _EditBackground(theme: theme),
      secondaryBackground: _DeleteBackground(theme: theme),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await _confirmDelete(context);
        } else if (direction == DismissDirection.startToEnd) {
          _showEditBookingModal(context, booking);
          return false;
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

  Future<bool?> _confirmDelete(BuildContext context) {
    return showAlertDialog(
      context: context,
      title: Strings.confirmDelete,
      content: Strings.deleteBookingMessage,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.deleteBooking,
      isDestructive: true,
    );
  }

  void _showEditBookingModal(BuildContext context, Booking booking) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => EditBookingScreen(booking: booking),
    );
  }
}

class _EditBackground extends StatelessWidget {
  const _EditBackground({required this.theme});

  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key(Keys.editBackground),
      decoration: BoxDecoration(
        color: KeeleyChartColors.chart3,
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
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground({required this.theme});

  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key(Keys.deleteBackground),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(Sizes.p12),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: Sizes.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_outline,
            color: theme.colorScheme.primaryForeground,
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
}
