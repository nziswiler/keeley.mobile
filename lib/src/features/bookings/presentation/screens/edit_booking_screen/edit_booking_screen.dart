import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/widgets/booking_form.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class EditBookingScreen extends ConsumerStatefulWidget {
  const EditBookingScreen({super.key});

  @override
  ConsumerState<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends ConsumerState<EditBookingScreen> {
  double get modalHeight => MediaQuery.of(context).size.height * 0.8;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      height: modalHeight,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: theme.radius,
      ),
      child: SingleChildScrollView(
        child: _buildModalContent(context, theme),
      ),
    );
  }

  Widget _buildModalContent(BuildContext context, ShadThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p24,
        vertical: Sizes.p24,
      ),
      child: const BookingForm(),
    );
  }
}
