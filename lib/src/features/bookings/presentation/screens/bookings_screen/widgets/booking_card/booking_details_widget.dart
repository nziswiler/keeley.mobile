import 'package:flutter/material.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BookingDetailsWidget extends StatelessWidget {
  const BookingDetailsWidget({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          booking.description ?? Strings.unnamedTransaction,
          style: theme.textTheme.small.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.foreground,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        gapH2,
        Text(
          Format.dateLocalized(booking.date),
          style: theme.textTheme.muted.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }
}
