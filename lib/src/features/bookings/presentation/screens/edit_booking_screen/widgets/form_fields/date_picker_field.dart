import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/edit_booking_controller.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/utils/validation_utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DatePickerField extends ConsumerWidget {
  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime?> onChanged;

  String? _validateDate(Object? value) {
    return ValidationUtils.validateRequiredField(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(editBookingControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadDatePickerFormField(
          id: Keys.dateField,
          label: Text(Strings.date),
          width: double.infinity,
          placeholder: Text(Strings.selectDate),
          initialValue: selectedDate,
          enabled: !bookingState.isLoading,
          onChanged: onChanged,
          validator: _validateDate,
        ),
      ],
    );
  }
}
