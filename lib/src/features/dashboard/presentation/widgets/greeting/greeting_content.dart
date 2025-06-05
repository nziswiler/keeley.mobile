import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class GreetingContent extends StatelessWidget {
  const GreetingContent({
    super.key,
    required this.greeting,
    required this.subtext,
  });

  final String greeting;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: theme.textTheme.h1.copyWith(
            color: theme.colorScheme.primaryForeground,
            fontWeight: FontWeight.bold,
          ),
        ),
        gapH4,
        Text(
          subtext,
          style: theme.textTheme.large.copyWith(
            color: theme.colorScheme.primaryForeground.withValues(alpha: 0.9),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
