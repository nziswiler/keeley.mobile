import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';

class CategoryExpense {
  const CategoryExpense({
    required this.category,
    required this.amount,
  });

  final BookingCategory category;
  final double amount;
}
