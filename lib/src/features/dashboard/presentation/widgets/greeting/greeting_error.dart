import 'package:flutter/material.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/greeting/greeting_content.dart';

class GreetingError extends StatelessWidget {
  const GreetingError({super.key});

  @override
  Widget build(BuildContext context) {
    return const GreetingContent(
      greeting: Strings.fallbackGreeting,
      subtext: Strings.morningSubtext,
    );
  }
}
