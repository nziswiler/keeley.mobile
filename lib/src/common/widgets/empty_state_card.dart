import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    this.title,
    this.height,
    this.icon = Icons.inbox_outlined,
    this.emptyTitle = 'Keine Daten vorhanden',
    this.emptyMessage = 'Es sind noch keine Daten verfügbar.',
    this.onAction,
    this.actionText,
  });

  final Widget? title;
  final double? height;
  final IconData icon;
  final String emptyTitle;
  final String emptyMessage;
  final VoidCallback? onAction;
  final String? actionText;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      title: title,
      child: Container(
        height: height ?? 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            if (onAction != null && actionText != null) ...[
              gapH16,
              ShadButton.outline(
                onPressed: onAction,
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Einfache Empty-State-Komponente ohne Card
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.icon = Icons.inbox_outlined,
    this.emptyTitle = 'Keine Daten vorhanden',
    this.emptyMessage = 'Es sind noch keine Daten verfügbar.',
    this.onAction,
    this.actionText,
  });

  final IconData icon;
  final String emptyTitle;
  final String emptyMessage;
  final VoidCallback? onAction;
  final String? actionText;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
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
          if (onAction != null && actionText != null) ...[
            gapH16,
            ShadButton.outline(
              onPressed: onAction,
              child: Text(actionText!),
            ),
          ],
        ],
      ),
    );
  }
}
