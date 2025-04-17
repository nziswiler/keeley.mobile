import 'package:keeley/domain/workspace_entity_base.dart';
import 'package:keeley/domain/finance/objects/booking_type.dart';

class Booking extends WorkspaceEntityBase {
  late DateTime date;
  String? description;
  late double amount;
  late BookingType type;

  String? customerId;

  String? orderId;

  String? accountId;

  // TODO: Implement BookingCategories
}
