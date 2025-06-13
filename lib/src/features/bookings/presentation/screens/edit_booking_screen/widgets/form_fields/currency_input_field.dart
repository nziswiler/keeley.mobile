import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/utils/validation_utils.dart';
import 'package:keeley/src/utils/format.dart';

class CurrencyInputField extends StatelessWidget {
  const CurrencyInputField({
    super.key,
    required this.controller,
    required this.id,
    required this.label,
    required this.placeholder,
    this.currency = Strings.chf,
    this.validator,
    this.enabled = true,
    this.decimalPlaces = 2,
    this.allowNegative = false,
    this.minValue,
    this.maxValue,
    this.onChanged,
    this.autovalidateMode,
  });

  final TextEditingController controller;

  final String id;

  final String label;

  final String placeholder;

  final String currency;

  final String? Function(String?)? validator;

  final bool enabled;

  final int decimalPlaces;

  final bool allowNegative;

  final double? minValue;

  final double? maxValue;

  final void Function(String)? onChanged;

  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      controller: controller,
      id: id,
      label: Text(label),
      leading: Text(currency),
      placeholder: Text(placeholder),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: _buildInputFormatters(),
      validator: validator ?? _defaultValidator,
      enabled: enabled,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
    );
  }

  List<TextInputFormatter> _buildInputFormatters() {
    final formatters = <TextInputFormatter>[];

    String pattern;
    if (allowNegative) {
      pattern = r'^-?\d*\.?\d{0,' + decimalPlaces.toString() + r'}';
    } else {
      pattern = r'^\d*\.?\d{0,' + decimalPlaces.toString() + r'}';
    }

    formatters.add(FilteringTextInputFormatter.allow(RegExp(pattern)));

    return formatters;
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Strings.requiredField;
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return Strings.invalidAmount;
    }

    if (!allowNegative && amount < 0) {
      return Strings.negativeValuesNotAllowed;
    }

    if (minValue != null && amount < minValue!) {
      return Strings.amountMustBeAtLeast
          .replaceAll('{0}', _formatCurrency(minValue!));
    }

    if (maxValue != null && amount > maxValue!) {
      return Strings.amountMustBeAtMost
          .replaceAll('{0}', _formatCurrency(maxValue!));
    }

    return null;
  }

  String _formatCurrency(double value) {
    return Format.chf(value, decimalPlaces: decimalPlaces);
  }
}

extension CurrencyInputFieldFactory on CurrencyInputField {
  static CurrencyInputField chf({
    Key? key,
    required TextEditingController controller,
    required String id,
    required String label,
    required String placeholder,
    String? Function(String?)? validator,
    bool enabled = true,
    double? minValue,
    double? maxValue,
    void Function(String)? onChanged,
    AutovalidateMode? autovalidateMode,
  }) {
    final actualValidator = validator ?? _defaultAmountValidator;

    return CurrencyInputField(
      key: key,
      controller: controller,
      id: id,
      label: label,
      placeholder: placeholder,
      currency: Strings.chf,
      validator: actualValidator,
      enabled: enabled,
      minValue: minValue,
      maxValue: maxValue,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
    );
  }

  static String? _defaultAmountValidator(String? value) {
    return ValidationUtils.validateAmount(value ?? '');
  }
}
