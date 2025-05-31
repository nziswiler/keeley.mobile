import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class GreetingLoading extends StatelessWidget {
  const GreetingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return SizedBox(
      height: Sizes.p64 + Sizes.p16, // Passende Höhe für den Content
      child: Center(
        child: CircularProgressIndicator(
          color: theme.colorScheme.primaryForeground,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
