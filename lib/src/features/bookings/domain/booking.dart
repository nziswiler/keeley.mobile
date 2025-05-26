import 'package:keeley/src/features/workspace_entity_base.dart';
import 'package:keeley/src/features/bookings/domain/booking_type.dart';

class Booking extends WorkspaceEntityBase {
  final DateTime date;
  final String? description;
  final double amount;
  final BookingType type;

  final String? customerId;
  final String? orderId;
  final String? accountId;

  Booking({
    required this.date,
    required this.amount,
    required this.type,
    this.description,
    this.customerId,
    this.orderId,
    this.accountId,
  });
}
