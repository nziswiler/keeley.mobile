import 'package:keeley/src/constants/strings.dart';

enum BookingCategory {
  housing(Strings.categoryHousing),
  groceries(Strings.categoryGroceries),
  transport(Strings.categoryTransport),
  leisure(Strings.categoryLeisure),
  salary(Strings.categorySalary),
  other(Strings.categoryOther);

  const BookingCategory(this.displayName);
  final String displayName;

  static BookingCategory fromString(String value) {
    switch (value) {
      case Strings.categoryHousing:
        return BookingCategory.housing;
      case Strings.categoryGroceries:
        return BookingCategory.groceries;
      case Strings.categoryTransport:
        return BookingCategory.transport;
      case Strings.categoryLeisure:
        return BookingCategory.leisure;
      case Strings.categorySalary:
        return BookingCategory.salary;
      case Strings.categoryOther:
        return BookingCategory.other;
      default:
        return BookingCategory.other;
    }
  }
}
