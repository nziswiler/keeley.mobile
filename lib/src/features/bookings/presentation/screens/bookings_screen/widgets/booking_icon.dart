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
      width: Sizes.p32 + Sizes.p4,
      height: Sizes.p32 + Sizes.p4,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Sizes.p8),
      ),
      child: Icon(
        icon,
        size: Sizes.p16 + Sizes.p2,
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
    if (isIncome) {
      return (theme.colorScheme as KeeleyColorScheme).income;
    } else {
      return theme.colorScheme.primary;
    }
  }
}
