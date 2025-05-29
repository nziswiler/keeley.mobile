import 'package:shadcn_ui/shadcn_ui.dart';

class Format {
  static String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNegative);
    return '${formatted}h';
  }

  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }

  static String chf(double amount, {int decimalPlaces = 0}) {
    final parts = amount.toStringAsFixed(decimalPlaces).split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '';

    String formattedInteger = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger += "'";
      }
      formattedInteger += integerPart[i];
    }

    final result = decimalPlaces > 0 && decimalPart.isNotEmpty
        ? '$formattedInteger.$decimalPart'
        : formattedInteger;

    return 'CHF $result';
  }

  static String dateLocalized(DateTime date) {
    const monthNames = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember'
    ];

    final day = date.day;
    final month = monthNames[date.month - 1];
    final year = date.year;

    return '$day. $month $year';
  }
}
