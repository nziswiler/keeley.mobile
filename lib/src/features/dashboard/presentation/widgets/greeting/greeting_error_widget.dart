import 'package:flutter/material.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/greeting/greeting_content_widget.dart';

class GreetingErrorWidget extends StatelessWidget {
  const GreetingErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const GreetingContentWidget(
      greeting: Strings.fallbackGreeting,
      subtext: Strings.morningSubtext,
    );
  }
}
