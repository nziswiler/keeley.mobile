import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.emptyTitle = 'Keine Daten vorhanden',
    this.emptyMessage = 'Es sind noch keine Daten verfügbar.',
  });

  final Widget? title;
  final IconData icon;
  final String emptyTitle;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      title: title,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              icon,
              size: 48,
              color: theme.colorScheme.mutedForeground,
            ),
            gapH16,
            Text(
              emptyTitle,
              style: theme.textTheme.large.copyWith(
                color: theme.colorScheme.foreground,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            gapH8,
            Text(
              emptyMessage,
              style: theme.textTheme.muted.copyWith(
                color: theme.colorScheme.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
