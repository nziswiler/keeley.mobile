import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/strings.dart';

class ShadFloatingActionButton extends StatelessWidget {
  const ShadFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.tooltip,
    this.heroTag,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final String? tooltip;
  final Object? heroTag;

  factory ShadFloatingActionButton.add({
    Key? key,
    required VoidCallback? onPressed,
    String? tooltip,
    Object? heroTag,
  }) {
    return ShadFloatingActionButton(
      key: key,
      onPressed: onPressed,
      tooltip: tooltip ?? Strings.add,
      heroTag: heroTag,
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      heroTag: heroTag,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.primaryForeground,
      child: child,
    );
  }
}
