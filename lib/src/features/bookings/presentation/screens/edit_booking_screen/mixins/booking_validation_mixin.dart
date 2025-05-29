import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/constants/strings.dart';

mixin BookingValidationMixin {
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

  String? validateCategory(
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
