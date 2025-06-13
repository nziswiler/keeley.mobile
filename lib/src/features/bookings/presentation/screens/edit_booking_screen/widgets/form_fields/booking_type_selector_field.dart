import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/edit_booking_controller.dart';
import 'package:keeley/src/common/widgets/toggle_button_group.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';

class BookingTypeSelectorField extends ConsumerWidget {
  const BookingTypeSelectorField({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final BookingType selectedType;
  final ValueChanged<BookingType?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(editBookingControllerProvider);

    return ToggleRadioGroup<BookingType>(
      items: [
        ToggleRadioItem<BookingType>(
          value: BookingType.income,
          label: Strings.income,
          icon: Icons.add,
        ),
        ToggleRadioItem<BookingType>(
          value: BookingType.expense,
          label: Strings.expense,
          icon: Icons.remove,
        )
      ],
      groupValue: selectedType,
      onChanged: !bookingState.isLoading ? onChanged : null,
      label: Strings.bookingType,
      enabled: !bookingState.isLoading,
    );
  }
}
