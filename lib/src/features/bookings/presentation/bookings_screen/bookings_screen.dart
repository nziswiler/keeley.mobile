import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/booking.dart';
import 'package:keeley/src/features/bookings/domain/booking_type.dart';
import 'package:keeley/src/features/bookings/presentation/bookings_screen/bookings_screen_controller.dart';
import 'package:keeley/src/features/bookings/presentation/edit_booking_screen/edit_booking_screen.dart';
import 'package:keeley/src/utils/async_value_ui.dart';
import 'package:keeley/src/common_widgets/shad_floating_action_button.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.bookings)),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            bookingsScreenControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );
          final bookingsQuery = ref.watch(bookingsQueryProvider);
          return FirestoreListView<Booking>(
            query: bookingsQuery,
            emptyBuilder: (context) => const Center(child: Text('No data')),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loadingBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
            itemBuilder: (context, snapshot) {
              final booking = snapshot.data();
              final isIncome = booking.type == BookingType.income;
              return Dismissible(
                key: Key('booking-${booking.id}'),
                background: Container(color: Colors.red),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => ref
                    .read(bookingsScreenControllerProvider.notifier)
                    .deleteBooking(booking),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        '${isIncome ? '+' : '-'} ${booking.amount.toStringAsFixed(0)} CHF',
                        style: TextStyle(
                          color: isIncome ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(booking.description ?? ''),
                    ],
                  ),
                  trailing: const Icon(Icons.more_vert),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return ShadFloatingActionButton.add(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) => const EditBookingScreen(),
              );
            },
            tooltip: Strings.newBooking,
          );
        },
      ),
    );
  }
}
