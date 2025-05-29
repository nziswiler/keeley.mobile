import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';

class BookingFormState {
  const BookingFormState({
    required this.selectedType,
    required this.selectedDate,
    required this.selectedCategory,
  });

  final BookingType selectedType;
  final DateTime selectedDate;
  final BookingCategory? selectedCategory;

  BookingFormState copyWith({
    BookingType? selectedType,
    DateTime? selectedDate,
    BookingCategory? selectedCategory,
  }) {
    return BookingFormState(
      selectedType: selectedType ?? this.selectedType,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
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
    return availableCategories.contains(category);
  }
}
