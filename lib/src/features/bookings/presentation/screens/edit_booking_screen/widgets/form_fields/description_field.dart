import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/edit_booking_controller.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/utils/validation_utils.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DescriptionField extends ConsumerWidget {
  const DescriptionField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  String? _validateDescription(String? value) {
    return ValidationUtils.validateRequiredTextField(value ?? '');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(editBookingControllerProvider);

    return ShadInputFormField(
      controller: controller,
      id: Keys.descriptionField,
      label: Text(Strings.description),
      placeholder: Text(Strings.descriptionPlaceholder),
      enabled: !bookingState.isLoading,
      validator: _validateDescription,
    );
  }
}
