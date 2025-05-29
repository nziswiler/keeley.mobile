import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/presentation/edit_booking_screen/form_fields/currency_input_field.dart';
import 'package:keeley/src/common_widgets/loading_button.dart';
import 'package:keeley/src/common_widgets/toggle_button_group.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/domain/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/booking_category.dart';
import 'package:keeley/src/features/bookings/presentation/edit_booking_screen/edit_booking_screen_controller.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/alert_dialogs.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class EditBookingScreen extends ConsumerStatefulWidget {
  const EditBookingScreen({super.key});

  @override
  ConsumerState<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends ConsumerState<EditBookingScreen> {
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;
  late final GlobalKey<ShadFormState> formKey;

  BookingType selectedType = BookingType.income;
  DateTime selectedDate = DateTime.now();
  BookingCategory? selectedCategory = BookingCategory.other;

  double get modalHeight => MediaQuery.of(context).size.height * 0.8;

  List<BookingCategory> get categories {
    if (selectedType == BookingType.income) {
      return [BookingCategory.salary, BookingCategory.other];
    } else {
      return BookingCategory.values
          .where((category) => category != BookingCategory.salary)
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    formKey = GlobalKey<ShadFormState>();
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    final categoryError = validateCategory(selectedCategory);
    if (categoryError != null) {
      setState(() {});
      return;
    }

    final amount = double.tryParse(amountController.text);
    final description = descriptionController.text.trim();

    await ref.read(editBookingScreenControllerProvider.notifier).saveBooking(
          date: selectedDate,
          amount: amount,
          type: selectedType,
          description: description,
          category: selectedCategory,
        );
  }

  String? validateAmount(String value) {
    validateRequiredField(value);

    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return Strings.invalidAmount;
    }
    return null;
  }

  String? validateRequiredTextField(String value) {
    if (value.trim().isEmpty) {
      return Strings.requiredField;
    }
    return null;
  }

  String? validateRequiredField(Object? value) {
    if (value == null) {
      return Strings.requiredField;
    }
    return null;
  }

  String? validateCategory(BookingCategory? category) {
    if (category == null) {
      return Strings.requiredField;
    }

    if (selectedType == BookingType.income) {
      if (category != BookingCategory.salary &&
          category != BookingCategory.other) {
        return Strings.invalidCategoryForIncome;
      }
    } else if (selectedType == BookingType.expense) {
      if (category == BookingCategory.salary) {
        return Strings.invalidCategoryForExpense;
      }
    }

    return null;
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void handleSaveError(Object error) {
    showExceptionToast(
      context: context,
      title: Strings.saveBookingFailed,
      exception: error,
    );
  }

  void handleSaveSuccess() {
    if (!mounted) return;
    showSuccessToast(
      context: context,
      description: Strings.saveBookingSuccess,
    );

    Navigator.of(context).pop();
  }

  void handleImagePicker() {
    // TODO: Implement image picker
    print('Image picker opened');
  }

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
      child: _buildForm(theme),
    );
  }

  Widget _buildForm(ShadThemeData theme) {
    return ShadForm(
      key: formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...buildFormFields(),
            gapH32,
            buildFormButtons(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildFormFields() {
    return [
      buildHeader(context),
      gapH24,
      buildBookingTypeSelector(context),
      gapH24,
      buildDatePicker(),
      gapH24,
      buildAmountField(),
      gapH24,
      buildDescriptionField(),
      gapH24,
      buildCategorySelector(context),
    ];
  }

  Widget buildHeader(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Row(
      key: const Key(Keys.headerSection),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(Strings.newBooking, style: theme.textTheme.h4),
        IconButton(
          key: const Key(Keys.closeButton),
          icon: Icon(
            Icons.close,
            color: theme.colorScheme.mutedForeground,
          ),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: Strings.closeDialog,
        ),
      ],
    );
  }

  Widget buildBookingTypeSelector(BuildContext context) {
    final bookingState = ref.watch(editBookingScreenControllerProvider);

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
      onChanged: !bookingState.isLoading
          ? (value) => _handleBookingTypeChange(value)
          : null,
      label: Strings.bookingType,
      id: Keys.bookingTypeField,
      enabled: !bookingState.isLoading,
    );
  }

  void _handleBookingTypeChange(BookingType? value) {
    if (value != null) {
      setState(() {
        selectedType = value;
        // Reset category if it's no longer valid for the new booking type
        if (!categories.contains(selectedCategory)) {
          selectedCategory = value == BookingType.income
              ? BookingCategory.salary
              : BookingCategory.other;
        }
      });
    }
  }

  Widget buildDatePicker() {
    final bookingState = ref.watch(editBookingScreenControllerProvider);

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
          onChanged: (date) => _handleDateChange(date),
          validator: validateRequiredField,
        ),
      ],
    );
  }

  void _handleDateChange(DateTime? date) {
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Widget buildCategorySelector(BuildContext context) {
    final theme = ShadTheme.of(context);
    final bookingState = ref.watch(editBookingScreenControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.category,
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w500),
        ),
        gapH8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShadSelect<BookingCategory>(
              placeholder: Text(Strings.selectCategory),
              minWidth: double.infinity,
              enabled: !bookingState.isLoading,
              initialValue: categories.contains(selectedCategory)
                  ? selectedCategory
                  : null,
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
              onChanged: (value) => _handleCategoryChange(value),
            ),
          ],
        ),
      ],
    );
  }

  void _handleCategoryChange(BookingCategory? value) {
    setState(() => selectedCategory = value);
  }

  Widget buildDescriptionField() {
    final bookingState = ref.watch(editBookingScreenControllerProvider);

    return ShadInputFormField(
      controller: descriptionController,
      id: Keys.descriptionField,
      label: Text(Strings.description),
      placeholder: Text(Strings.descriptionPlaceholder),
      enabled: !bookingState.isLoading,
      validator: validateRequiredTextField,
    );
  }

  Widget buildFormButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildSubmitButton(),
        gapH12,
        ShadButton.secondary(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(Strings.cancel),
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return Consumer(
      builder: (context, ref, child) {
        final bookingState = ref.watch(editBookingScreenControllerProvider);

        // Listen for state changes to handle errors and success
        ref.listen(editBookingScreenControllerProvider, (previous, next) {
          if (next.hasError) {
            handleSaveError(next.error!);
          }

          if (next.isSuccess) {
            handleSaveSuccess();
          }
        });

        return LoadingButton(
          key: const Key(Keys.saveBookingButton),
          onPressed: () => _handleSubmitButtonPressed(),
          isLoading: bookingState.isLoading,
          child: Text(Strings.saveBooking),
        );
      },
    );
  }

  Future<void> _handleSubmitButtonPressed() async {
    if (!formKey.currentState!.saveAndValidate()) {
      return;
    }
    await handleSubmit();
  }

  Widget buildAmountField() {
    final bookingState = ref.watch(editBookingScreenControllerProvider);

    return CurrencyInputFieldFactory.chf(
      controller: amountController,
      id: Keys.amountField,
      label: Strings.amount,
      placeholder: Strings.amountPlaceholder,
      enabled: !bookingState.isLoading,
      validator: (value) => validateAmount(value ?? ''),
    );
  }
}
