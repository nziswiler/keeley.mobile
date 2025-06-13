import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/scrollable_scaffold.dart';
import 'package:keeley/src/common/widgets/shad_floating_action_button.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/bookings_content.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/edit_booking_screen.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollableScaffold(
      key: const Key(Keys.bookingsScreen),
      title: Strings.bookings,
      builder: (scrollController, padding) {
        return BookingsContent(
          scrollController: scrollController,
          padding: padding,
        );
      },
      floatingActionButton: ShadFloatingActionButton.add(
        key: const Key(Keys.floatingActionButton),
        onPressed: () => _showCreateBookingModal(context),
        tooltip: Strings.newBooking,
      ),
    );
  }

  void _showCreateBookingModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => const EditBookingScreen(),
    );
  }
}
