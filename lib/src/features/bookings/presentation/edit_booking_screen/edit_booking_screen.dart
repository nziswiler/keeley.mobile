import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common_widgets/currency_input_field.dart';
import 'package:keeley/src/common_widgets/loading_button.dart';
import 'package:keeley/src/common_widgets/toggle_button_group.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/domain/booking_type.dart';
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
  String? selectedCategory;

  double get modalHeight => MediaQuery.of(context).size.height * 0.8;

  // Categories
  List<String> get categories => [
        Strings.categoryRent,
        Strings.categoryFood,
        Strings.categoryTransport,
        Strings.categoryLeisure,
        Strings.categoryOther,
      ];

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
    final amount = double.tryParse(amountController.text);
    final description = descriptionController.text.trim();
    final bookingType = selectedType;
    final selectedDateFromForm = selectedDate;

    await ref.read(editBookingScreenControllerProvider.notifier).saveBooking(
          date: selectedDateFromForm,
          amount: amount,
          type: bookingType,
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
    return Container(
      height: modalHeight,
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.background,
        borderRadius: ShadTheme.of(context).radius,
      ),
      child: SingleChildScrollView(
        child: buildModalContent(context),
      ),
    );
  }

  Widget buildModalContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: buildForm(),
    );
  }

  Widget buildForm() {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Strings.newBooking,
          style: ShadTheme.of(context).textTheme.h3,
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
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
          ? (value) {
              if (value != null) {
                setState(() {
                  selectedType = value;
                });
              }
            }
          : null,
      label: Strings.bookingType,
      id: Keys.bookingTypeField,
      enabled: !bookingState.isLoading,
    );
  }

  Widget buildDatePicker() {
    final bookingState = ref.watch(editBookingScreenControllerProvider);

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadDatePickerFormField(
            id: Keys.dateField,
            label: Text(Strings.date),
            width: double.infinity,
            placeholder: Text(Strings.selectDate),
            initialValue: selectedDate,
            enabled: !bookingState.isLoading,
            onChanged: (date) {
              if (date != null) {
                setState(() {
                  selectedDate = date;
                });
              }
            },
            validator: validateRequiredField,
          ),
        ],
      ),
    );
  }

  Widget buildCategorySelector(BuildContext context) {
    final bookingState = ref.watch(editBookingScreenControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.category,
          style: ShadTheme.of(context).textTheme.small.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        gapH8,
        ShadSelect<String>(
          placeholder: Text(Strings.selectCategory),
          minWidth: double.infinity,
          enabled: !bookingState.isLoading,
          options: categories
              .map(
                (category) => ShadOption(
                  value: category,
                  child: Text(category),
                ),
              )
              .toList(),
          selectedOptionBuilder: (_, value) => Text(value),
          onChanged: (value) {
            setState(() => selectedCategory = value);
          },
        ),
      ],
    );
  }

  Widget buildDescriptionField() {
    final bookingState = ref.watch(editBookingScreenControllerProvider);

    return ShadInputFormField(
        controller: descriptionController,
        id: Keys.descriptionField,
        label: Text(Strings.description),
        placeholder: Text(Strings.descriptionPlaceholder),
        enabled: !bookingState.isLoading,
        validator: validateRequiredTextField);
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
          key: Key(Keys.saveBookingButton),
          onPressed: () async {
            if (!formKey.currentState!.saveAndValidate()) {
              return;
            }
            await handleSubmit();
          },
          isLoading: bookingState.isLoading,
          child: Text(Strings.saveBooking),
        );
      },
    );
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
