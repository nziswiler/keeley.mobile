import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/constants/strings.dart';

/// Utility class that provides validation methods for booking form fields.
/// Each method returns null if the validation passes, or an error string if it fails.
class ValidationUtils {
  /// Validates an amount value, ensuring it is not empty and is a positive number.
  static String? validateAmount(String value) {
    // First check if field is not empty
    final requiredError = validateRequiredField(value);
    if (requiredError != null) {
      return requiredError;
    }

    // Then validate as a positive number
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return Strings.invalidAmount;
    }
    return null;
  }

  /// Validates a text field ensuring it is not empty after trimming.
  static String? validateRequiredTextField(String value) {
    if (value.trim().isEmpty) {
      return Strings.requiredField;
    }
    return null;
  }

  /// Validates that a value is not null.
  static String? validateRequiredField(Object? value) {
    if (value == null) {
      return Strings.requiredField;
    }
    return null;
  }

  /// Validates that the selected category is valid for the given booking type.
  static String? validateCategory(
      BookingCategory? category, BookingType selectedType) {
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
}
