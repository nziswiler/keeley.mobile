import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/edit_booking_controller.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/widgets/form_fields/booking_type_selector_field.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/widgets/form_fields/category_selector_field.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/widgets/form_fields/currency_input_field.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/widgets/form_fields/date_picker_field.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/widgets/form_fields/description_field.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/widgets/form_actions.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/widgets/form_header.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/models/booking_form_state.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/mixins/booking_validation_mixin.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/alert_dialogs.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BookingForm extends ConsumerStatefulWidget {
  const BookingForm({super.key});

  @override
  ConsumerState<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends ConsumerState<BookingForm>
    with BookingValidationMixin {
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;
  late final GlobalKey<ShadFormState> formKey;

  late BookingFormState formState;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    formKey = GlobalKey<ShadFormState>();

    formState = BookingFormState(
      selectedType: BookingType.income,
      selectedDate: DateTime.now(),
      selectedCategory: BookingCategory.other,
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _updateFormState(BookingFormState newState) {
    setState(() {
      formState = newState;
    });
  }

  void _handleBookingTypeChange(BookingType? value) {
    if (value == null) return;

    final newState = formState.copyWith(selectedType: value);

    // Reset category if it's no longer valid for the new booking type
    if (!newState.isCategoryValid(formState.selectedCategory)) {
      final defaultCategory = value == BookingType.income
          ? BookingCategory.salary
          : BookingCategory.other;
      _updateFormState(newState.copyWith(selectedCategory: defaultCategory));
    } else {
      _updateFormState(newState);
    }
  }

  void _handleDateChange(DateTime? date) {
    if (date != null) {
      _updateFormState(formState.copyWith(selectedDate: date));
    }
  }

  void _handleCategoryChange(BookingCategory? category) {
    _updateFormState(formState.copyWith(selectedCategory: category));
  }

  Future<void> _handleSubmit() async {
    if (!formKey.currentState!.saveAndValidate()) {
      return;
    }

    final categoryError =
        validateCategory(formState.selectedCategory, formState.selectedType);
    if (categoryError != null) {
      setState(() {});
      return;
    }

    final amount = double.tryParse(amountController.text);
    final description = descriptionController.text.trim();

    await ref.read(editBookingControllerProvider.notifier).saveBooking(
          date: formState.selectedDate,
          amount: amount!,
          type: formState.selectedType,
          description: description,
          category: formState.selectedCategory,
        );
  }

  void _handleSaveError(Object error) {
    showExceptionToast(
      context: context,
      title: Strings.saveBookingFailed,
      exception: error,
    );
  }

  void _handleSaveSuccess() {
    if (!mounted) return;
    showSuccessToast(
      context: context,
      description: Strings.saveBookingSuccess,
    );
    Navigator.of(context).pop();
  }

  void _handleClose() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for state changes to handle errors and success
    ref.listen(editBookingControllerProvider, (previous, next) {
      if (next.hasError) {
        _handleSaveError(next.error!);
      }

      if (next.isSuccess) {
        _handleSaveSuccess();
      }
    });

    return ShadForm(
      key: formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormHeader(onClose: _handleClose),
            gapH24,
            BookingTypeSelectorField(
              selectedType: formState.selectedType,
              onChanged: _handleBookingTypeChange,
            ),
            gapH24,
            DatePickerField(
              selectedDate: formState.selectedDate,
              onChanged: _handleDateChange,
              validator: validateRequiredField,
            ),
            gapH24,
            CurrencyInputFieldFactory.chf(
              controller: amountController,
              id: Keys.amountField,
              label: Strings.amount,
              placeholder: Strings.amountPlaceholder,
              enabled: !ref.watch(editBookingControllerProvider).isLoading,
              validator: (value) => validateAmount(value ?? ''),
            ),
            gapH24,
            DescriptionField(
              controller: descriptionController,
              validator: validateRequiredTextField,
            ),
            gapH24,
            CategorySelectorField(
              categories: formState.availableCategories,
              selectedCategory: formState.selectedCategory,
              onChanged: _handleCategoryChange,
            ),
            gapH32,
            FormActions(
              onSubmit: _handleSubmit,
              onCancel: _handleClose,
            ),
          ],
        ),
      ),
    );
  }
}
