enum BookingType {
  income(0),
  expense(1);

  final int value;
  const BookingType(this.value);

  static BookingType fromValue(int value) {
    switch (value) {
      case 0:
        return BookingType.income;
      case 1:
        return BookingType.expense;
      default:
        throw ArgumentError('Unknown BookingType value: $value');
    }
  }

  String get displayName {
    switch (this) {
      case BookingType.income:
        return 'Income';
      case BookingType.expense:
        return 'Expense';
    }
  }
}
