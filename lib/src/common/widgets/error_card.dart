import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.error,
    this.title,
    this.height,
    this.errorTitle = 'Fehler beim Laden der Daten',
    this.onRetry,
  });

  final Object error;
  final Widget? title;
  final double? height;
  final String errorTitle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      title: title,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: theme.colorScheme.destructive,
              size: 48,
            ),
            gapH16,
            Text(
              errorTitle,
              style: theme.textTheme.h4.copyWith(
                color: theme.colorScheme.destructive,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            gapH8,
            Text(
              _getErrorMessage(error),
              style: theme.textTheme.small.copyWith(
                color: theme.colorScheme.mutedForeground,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (onRetry != null) ...[
              gapH16,
              ShadButton.outline(
                onPressed: onRetry,
                child: const Text('Erneut versuchen'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(Object error) {
    // Verbesserung der Fehlermeldungen für bessere Benutzererfahrung
    final message = error.toString();
    if (message.contains('network') || message.contains('Network')) {
      return 'Netzwerkfehler. Bitte überprüfen Sie Ihre Internetverbindung.';
    }
    if (message.contains('auth') || message.contains('Auth')) {
      return 'Authentifizierungsfehler. Bitte loggen Sie sich erneut ein.';
    }
    if (message.contains('permission') || message.contains('Permission')) {
      return 'Keine Berechtigung für diese Aktion.';
    }
    return message.length > 100 ? '${message.substring(0, 100)}...' : message;
  }
}

/// Einfache Error-Komponente ohne Card
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.error,
    this.errorTitle = 'Ein Fehler ist aufgetreten',
    this.onRetry,
  });

  final Object error;
  final String errorTitle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.destructive,
          ),
          gapH16,
          Text(
            errorTitle,
            style: theme.textTheme.h4.copyWith(
              color: theme.colorScheme.destructive,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          gapH8,
          Text(
            _getErrorMessage(error),
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (onRetry != null) ...[
            gapH16,
            ShadButton.outline(
              onPressed: onRetry,
              child: const Text('Erneut versuchen'),
            ),
          ],
        ],
      ),
    );
  }

  String _getErrorMessage(Object error) {
    final message = error.toString();
    if (message.contains('network') || message.contains('Network')) {
      return 'Netzwerkfehler. Bitte überprüfen Sie Ihre Internetverbindung.';
    }
    if (message.contains('auth') || message.contains('Auth')) {
      return 'Authentifizierungsfehler. Bitte loggen Sie sich erneut ein.';
    }
    if (message.contains('permission') || message.contains('Permission')) {
      return 'Keine Berechtigung für diese Aktion.';
    }
    return message.length > 100 ? '${message.substring(0, 100)}...' : message;
  }
}
