// widgets/booking_icon.dart
import 'package:flutter/material.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
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
    // Verwende Theme-Farben für konsistente Darstellung
    if (isIncome) {
      return (theme.colorScheme as KeeleyColorScheme).income;
    } else {
      return theme.colorScheme.primary;
    }
  }
}
