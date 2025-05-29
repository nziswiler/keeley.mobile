// widgets/booking_card.dart
import 'package:flutter/material.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/booking_icon.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
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
    final formattedDate = DateFormat('d MMMM, yyyy').format(booking.date);

    return ShadCard(
      key: Key('${Keys.bookingCard}-${booking.id}'),
      shadows: const [], // Entfernt den Schatten für flaches Design
      padding: EdgeInsets.zero, // Entfernt das Standard-Padding der Card
      border: Border.all(color: Colors.transparent), // Entfernt den Border
      radius: BorderRadius.circular(12), // Rundet die Ecken ab
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.p8,
          vertical: Sizes.p12,
        ),
        child: Row(
          children: [
            BookingIcon(
              category: booking.category,
              isIncome: isIncome,
            ),
            gapW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.description ?? Strings.unnamedTransaction,
                    style: theme.textTheme.small.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.foreground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formattedDate,
                    style: theme.textTheme.muted.copyWith(
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            _buildAmountDisplay(context, theme, isIncome),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountDisplay(
      BuildContext context, ShadThemeData theme, bool isIncome) {
    final keeleyTheme = theme.colorScheme as KeeleyColorScheme;
    final amountColor = isIncome
        ? keeleyTheme.income // Theme-Grün für Einnahmen
        : theme.colorScheme.primary; // Primary-Farbe für Ausgaben

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${isIncome ? '+' : '-'} \$${booking.amount.toStringAsFixed(0)}',
          style: theme.textTheme.small.copyWith(
            fontWeight: FontWeight.w600,
            color: amountColor,
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}
