import 'package:keeley/src/constants/strings.dart';

class GreetingUtils {
  GreetingUtils._();

  static String getTimeBasedGreeting(String firstName) {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return Strings.morningGreeting.replaceAll('{0}', firstName);
    } else if (hour >= 12 && hour < 17) {
      return Strings.afternoonGreeting.replaceAll('{0}', firstName);
    } else if (hour >= 17 && hour < 24) {
      return Strings.eveningGreeting.replaceAll('{0}', firstName);
    } else {
      return Strings.nightGreeting.replaceAll('{0}', firstName);
    }
  }

  static String getTimeBasedSubtext() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return Strings.morningSubtext;
    } else if (hour >= 12 && hour < 17) {
      return Strings.afternoonSubtext;
    } else if (hour >= 17 && hour < 24) {
      return Strings.eveningSubtext;
    } else {
      return Strings.nightSubtext;
    }
  }

  static String extractFirstName(String? displayName, String? email) {
    String fullName = '';

    if (displayName != null && displayName.isNotEmpty) {
      fullName = displayName;
    } else if (email != null && email.isNotEmpty) {
      final namePart = email.split('@').first;
      fullName = namePart.substring(0, 1).toUpperCase() + namePart.substring(1);
    } else {
      return Strings.fallbackGreetingName;
    }

    final firstName = fullName.split(' ').first;
    return firstName;
  }
}
