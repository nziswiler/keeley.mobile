import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({
    super.key,
    this.title,
    this.height,
    this.loadingText = 'Laden...',
  });

  final Widget? title;
  final double? height;
  final String loadingText;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      title: title,
      child: SizedBox(
        height: height ?? 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                  strokeWidth: 2,
                ),
              ),
              gapH16,
              Text(
                loadingText,
                style: theme.textTheme.muted.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Einfache Loading-Komponente ohne Card
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.loadingText = 'Laden...',
    this.size = 32,
  });

  final String loadingText;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
              strokeWidth: 2,
            ),
          ),
          gapH16,
          Text(
            loadingText,
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
