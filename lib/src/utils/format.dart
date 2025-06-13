import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/strings.dart';

class Format {
  static String chf(double amount, {int decimalPlaces = 0}) {
    final formatter = NumberFormat.currency(
      locale: Strings.localeDeCh,
      symbol: Strings.chf,
      decimalDigits: decimalPlaces,
    );

    return formatter.format(amount);
  }

  static String dateLocalized(DateTime date) {
    final formatter = DateFormat('d. MMMM y', Strings.localeDe);

    return formatter.format(date);
  }
}
