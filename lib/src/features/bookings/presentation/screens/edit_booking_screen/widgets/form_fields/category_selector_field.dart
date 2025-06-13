import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/edit_booking_controller.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/utils/validation_utils.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CategorySelectorField extends ConsumerWidget {
  const CategorySelectorField({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
    this.bookingType = BookingType.expense,
  });

  final List<BookingCategory> categories;
  final BookingCategory? selectedCategory;
  final ValueChanged<BookingCategory?> onChanged;
  final BookingType bookingType;

  String? _validateCategory(BookingCategory? value) {
    return ValidationUtils.validateCategory(value, bookingType);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(editBookingControllerProvider);

    return ShadSelectFormField<BookingCategory>(
      id: Keys.categoryField,
      placeholder: Text(Strings.selectCategory),
      label: Text(Strings.category),
      minWidth: double.infinity,
      enabled: !bookingState.isLoading,
      initialValue:
          categories.contains(selectedCategory) ? selectedCategory : null,
      options: categories
          .map(
            (category) => ShadOption(
              key: Key('${Keys.categoryOption}_${category.name}'),
              value: category,
              child: Text(category.displayName),
            ),
          )
          .toList(),
      selectedOptionBuilder: (_, value) => Text(value.displayName),
      onChanged: onChanged,
      validator: _validateCategory,
    );
  }
}
