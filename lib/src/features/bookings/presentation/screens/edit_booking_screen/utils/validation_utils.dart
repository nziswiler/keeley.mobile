import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/constants/strings.dart';

class ValidationUtils {
  static String? validateAmount(String value) {
    final requiredError = validateRequiredField(value);
    if (requiredError != null) {
      return requiredError;
    }

    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return Strings.invalidAmount;
    }
    return null;
  }

  static String? validateRequiredTextField(String value) {
    if (value.trim().isEmpty) {
      return Strings.requiredField;
    }
    return null;
  }

  static String? validateRequiredField(Object? value) {
    if (value == null) {
      return Strings.requiredField;
    }
    return null;
  }

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
