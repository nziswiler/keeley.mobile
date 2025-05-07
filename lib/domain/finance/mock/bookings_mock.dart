import 'package:keeley/domain/finance/model/booking.dart';
import 'package:keeley/domain/finance/objects/booking_type.dart';

final List<Booking> mockBookings = [
  Booking(
    date: DateTime(2025, 1, 15),
    amount: 15000,
    description: 'Salär NASA',
    type: BookingType.income,
  ),
  Booking(
    date: DateTime(2025, 1, 16),
    amount: 6475,
    description: 'Neuer Raumanzug',
    type: BookingType.expense,
  ),
  Booking(
    date: DateTime(2025, 1, 17),
    amount: 120,
    description: 'Moonboots',
    type: BookingType.expense,
  ),
  Booking(
    date: DateTime(2025, 1, 18),
    amount: 1200,
    description: 'Spesen Treibstoff für Rakete',
    type: BookingType.income,
  ),
  Booking(
    date: DateTime(2025, 1, 18),
    amount: 1460,
    description: 'Amerika Flagge',
    type: BookingType.expense,
  ),
  Booking(
    date: DateTime(2025, 1, 19),
    amount: 1200,
    description: 'Schraube für Rakete',
    type: BookingType.income,
  ),
  Booking(
    date: DateTime(2025, 1, 20),
    amount: 5,
    description: 'Moonboots',
    type: BookingType.expense,
  ),
  Booking(
    date: DateTime(2025, 1, 21),
    amount: 1200,
    description: 'Schraube für Rakete',
    type: BookingType.income,
  ),
];
