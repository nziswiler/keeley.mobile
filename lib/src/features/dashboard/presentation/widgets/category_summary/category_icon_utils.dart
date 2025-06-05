import 'package:flutter/material.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';

class CategoryIconUtils {
  CategoryIconUtils._();

  static IconData getIconForCategory(BookingCategory category) {
    switch (category) {
      case BookingCategory.housing:
        return Icons.home_outlined;
      case BookingCategory.groceries:
        return Icons.shopping_cart_outlined;
      case BookingCategory.transport:
        return Icons.directions_car_outlined;
      case BookingCategory.leisure:
        return Icons.sports_esports_outlined;
      case BookingCategory.salary:
        return Icons.attach_money;
      case BookingCategory.other:
        return Icons.category_outlined;
    }
  }
}
