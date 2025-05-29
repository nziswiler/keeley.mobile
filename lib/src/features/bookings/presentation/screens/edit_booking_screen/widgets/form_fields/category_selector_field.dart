import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/edit_booking_controller.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CategorySelectorField extends ConsumerWidget {
  const CategorySelectorField({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
  });

  final List<BookingCategory> categories;
  final BookingCategory? selectedCategory;
  final ValueChanged<BookingCategory?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final bookingState = ref.watch(editBookingControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.category,
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w500),
        ),
        gapH8,
        ShadSelect<BookingCategory>(
          placeholder: Text(Strings.selectCategory),
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
        ),
      ],
    );
  }
}
