// widgets/booking_icon.dart
import 'package:flutter/material.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BookingIcon extends StatelessWidget {
  const BookingIcon({
    super.key,
    required this.category,
    required this.isIncome,
  });

  final BookingCategory? category;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final icon = _getIconForCategory(category);
    final backgroundColor = _getBackgroundColor(theme);

    return Container(
      key: Key('${Keys.bookingIcon}-${category?.name ?? 'default'}'),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 18,
        color: theme.colorScheme.primaryForeground,
      ),
    );
  }

  IconData _getIconForCategory(BookingCategory? category) {
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
      case null:
        return isIncome ? Icons.trending_up : Icons.trending_down;
    }
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    // Use theme colors with category-specific tints
    switch (category) {
      case BookingCategory.housing:
        return const Color(0xFF16A34A); // Green-600
      case BookingCategory.groceries:
        return const Color(0xFFEA580C); // Orange-600
      case BookingCategory.transport:
        return const Color(0xFF2563EB); // Blue-600
      case BookingCategory.leisure:
        return const Color(0xFF9333EA); // Purple-600
      case BookingCategory.salary:
        return const Color(0xFF059669); // Emerald-600
      case BookingCategory.other:
      case null:
        return isIncome
            ? const Color(0xFF16A34A) // Green-600 for income
            : theme.colorScheme.muted; // Theme muted for other expenses
    }
  }
}
