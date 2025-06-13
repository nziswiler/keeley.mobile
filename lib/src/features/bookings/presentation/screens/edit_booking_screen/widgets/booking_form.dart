import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:keeley/src/features/bookings/domain/model/booking.dart';
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
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/utils/validation_utils.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/toasts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BookingForm extends ConsumerStatefulWidget {
  const BookingForm({super.key, this.booking});

  final Booking? booking;

  @override
  ConsumerState<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends ConsumerState<BookingForm> {
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;
  late final GlobalKey<ShadFormState> formKey;

  BookingType selectedType = BookingType.income;
  DateTime selectedDate = DateTime.now();
  BookingCategory? selectedCategory;
  PlatformFile? selectedReceipt;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    formKey = GlobalKey<ShadFormState>();

    if (widget.booking != null) {
      final booking = widget.booking!;
      amountController.text = booking.amount.toString();
      descriptionController.text = booking.description ?? '';
      selectedType = booking.type;
      selectedDate = booking.date;
      selectedCategory = booking.category;
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  List<BookingCategory> get availableCategories {
    if (selectedType == BookingType.income) {
      return [BookingCategory.salary, BookingCategory.other];
    } else {
      return BookingCategory.values
          .where((category) => category != BookingCategory.salary)
          .toList();
    }
  }

  bool isCategoryValid(BookingCategory? category) {
    return category != null && availableCategories.contains(category);
  }

  void _handleBookingTypeChange(BookingType? value) {
    if (value == null) return;

    setState(() {
      selectedType = value;

      if (!isCategoryValid(selectedCategory)) {
        selectedCategory = null;
      }
    });
  }

  void _handleDateChange(DateTime? date) {
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _handleCategoryChange(BookingCategory? category) {
    if (category != null) {
      setState(() {
        selectedCategory = category;
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!formKey.currentState!.saveAndValidate()) return;

    final categoryError =
        ValidationUtils.validateCategory(selectedCategory, selectedType);
    if (categoryError != null) {
      setState(() {});
      return;
    }

    final amount = double.tryParse(amountController.text);
    final description = descriptionController.text.trim();

    await ref.read(editBookingControllerProvider.notifier).saveBooking(
          date: selectedDate,
          amount: amount!,
          type: selectedType,
          description: description,
          category: selectedCategory!,
          existingBooking: widget.booking,
        );
  }

  void _handleSaveError(Object error) {
    showExceptionToast(
      context: context,
      title: Strings.saveFaield,
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
    ref.listen(editBookingControllerProvider, (previous, next) {
      if (next.hasError) _handleSaveError(next.error!);
      if (next.hasValue && !next.isLoading) _handleSaveSuccess();
    });

    return ShadForm(
      key: formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormHeader(
              onClose: _handleClose,
              isEditing: widget.booking != null,
            ),
            gapH24,
            BookingTypeSelectorField(
              selectedType: selectedType,
              onChanged: _handleBookingTypeChange,
            ),
            gapH24,
            DatePickerField(
              selectedDate: selectedDate,
              onChanged: _handleDateChange,
            ),
            gapH24,
            CurrencyInputFieldFactory.chf(
              controller: amountController,
              id: Keys.amountField,
              label: Strings.amount,
              placeholder: Strings.amountPlaceholder,
            ),
            gapH24,
            DescriptionField(
              controller: descriptionController,
            ),
            gapH24,
            CategorySelectorField(
              categories: availableCategories,
              selectedCategory: selectedCategory,
              onChanged: _handleCategoryChange,
              bookingType: selectedType,
            ),
            gapH24,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH8,
                SizedBox(
                  width: double.infinity,
                  child: ShadButton.outline(
                    onPressed: () async {
                      final result = await FilePicker.platform
                          .pickFiles(type: FileType.any);
                      if (result != null && result.files.isNotEmpty) {
                        setState(() {
                          selectedReceipt = result.files.first;
                        });
                      }
                    },
                    child: Text(
                        selectedReceipt?.name ?? Strings.receiptPlaceholder),
                  ),
                ),
              ],
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
