import 'package:flutter/material.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BookingAmount extends StatelessWidget {
  const BookingAmount({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isIncome = booking.type == BookingType.income;
    final keeleyTheme = theme.colorScheme as KeeleyColorScheme;
    final amountColor =
        isIncome ? keeleyTheme.income : theme.colorScheme.primary;
    final prefix = isIncome ? '+' : '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$prefix ${Format.chf(booking.amount)}',
          style: theme.textTheme.small.copyWith(
            fontWeight: FontWeight.w600,
            color: amountColor,
          ),
        ),
        gapH2,
      ],
    );
  }
}
