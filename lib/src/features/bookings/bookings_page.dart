import 'package:flutter/material.dart';
import 'package:keeley/src/features/finance/domain/booking.dart';
import 'package:keeley/src/features/finance/domain/booking_type.dart';
import 'new_booking_page.dart'; // Stelle sicher, dass dieser Importpfad korrekt ist

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  List<Booking> get mockBookings => [
        Booking(
          date: DateTime(2025, 1, 1),
          amount: 15000,
          type: BookingType.income,
          description: 'Salär NASA',
        ),
        Booking(
          date: DateTime(2025, 1, 2),
          amount: 6475,
          type: BookingType.expense,
          description: 'Neuer Raumanzug',
        ),
        Booking(
          date: DateTime(2025, 1, 3),
          amount: 120,
          type: BookingType.expense,
          description: 'Moonboots',
        ),
        Booking(
          date: DateTime(2025, 1, 4),
          amount: 1200,
          type: BookingType.income,
          description: 'Spesen Treibstoff für Rakete',
        ),
        Booking(
          date: DateTime(2025, 1, 5),
          amount: 1460,
          type: BookingType.expense,
          description: 'Amerika Flagge',
        ),
        Booking(
          date: DateTime(2025, 1, 6),
          amount: 1200,
          type: BookingType.income,
          description: 'Schraube für Rakete',
        ),
        Booking(
          date: DateTime(2025, 1, 7),
          amount: 5,
          type: BookingType.expense,
          description: 'Moonboots',
        ),
        Booking(
          date: DateTime(2025, 1, 8),
          amount: 1200,
          type: BookingType.income,
          description: 'Schraube für Rakete',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final bookings = mockBookings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Buchungen'),
        actions: const [
          Icon(Icons.download),
        ],
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          final isIncome = booking.type == BookingType.income;
          return ListTile(
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => const NewBookingPage(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
