import 'package:flutter/material.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/booking_icon.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/booking_card/booking_details_widget.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/booking_card/booking_amount_widget.dart';
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
              child: BookingDetailsWidget(
                booking: booking,
              ),
            ),
            BookingAmountWidget(
              booking: booking,
            ),
          ],
        ),
      ),
    );
  }
}
