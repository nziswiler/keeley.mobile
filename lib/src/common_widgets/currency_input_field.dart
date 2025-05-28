import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CurrencyInputField extends StatelessWidget {
  const CurrencyInputField({
    super.key,
    required this.controller,
    required this.id,
    required this.label,
    required this.placeholder,
    this.currency = 'CHF',
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
      return 'Betrag ist erforderlich';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Ungültiger Betrag';
    }

    if (!allowNegative && amount < 0) {
      return 'Negative Werte sind nicht erlaubt';
    }

    if (minValue != null && amount < minValue!) {
      return 'Betrag muss mindestens ${_formatCurrency(minValue!)} sein';
    }

    if (maxValue != null && amount > maxValue!) {
      return 'Betrag darf höchstens ${_formatCurrency(maxValue!)} sein';
    }

    return null;
  }

  String _formatCurrency(double value) {
    return '$currency ${value.toStringAsFixed(decimalPlaces)}';
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
  }) =>
      CurrencyInputField(
        key: key,
        controller: controller,
        id: id,
        label: label,
        placeholder: placeholder,
        currency: 'CHF',
        validator: validator,
        enabled: enabled,
        minValue: minValue,
        maxValue: maxValue,
        onChanged: onChanged,
        autovalidateMode: autovalidateMode,
      );
}
