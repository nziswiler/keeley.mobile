import 'package:flutter/material.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/booking_icon.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isIncome = booking.type == BookingType.income;

    return ShadCard(
      key: Key('${Keys.bookingCard}-${booking.id}'),
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Row(
          children: [
            BookingIcon(
              category: booking.category,
              isIncome: isIncome,
            ),
            gapW12,
            Expanded(
              child: _BookingDetails(
                booking: booking,
                theme: theme,
              ),
            ),
            _AmountDisplay(
              booking: booking,
              theme: theme,
              isIncome: isIncome,
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingDetails extends StatelessWidget {
  const _BookingDetails({
    required this.booking,
    required this.theme,
  });

  final Booking booking;
  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
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

class _AmountDisplay extends StatelessWidget {
  const _AmountDisplay({
    required this.booking,
    required this.theme,
    required this.isIncome,
  });

  final Booking booking;
  final ShadThemeData theme;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
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
