import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/edit_booking_controller.dart';
import 'package:keeley/src/common_widgets/loading_button.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FormActions extends ConsumerWidget {
  const FormActions({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(editBookingControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LoadingButton(
          key: const Key(Keys.saveBookingButton),
          onPressed: onSubmit,
          isLoading: bookingState.isLoading,
          child: Text(Strings.saveBooking),
        ),
        gapH12,
        ShadButton.secondary(
          onPressed: onCancel,
          child: Text(Strings.cancel),
        ),
      ],
    );
  }
}
