import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.variant = LoadingButtonVariant.primary,
    this.loadingText,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final LoadingButtonVariant variant;
  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    final isInteractable = !isLoading && onPressed != null;
    return _buildButton(
      onPressed: isInteractable ? onPressed : null,
      child: isLoading ? _buildLoadingContent(context) : child,
    );
  }

  Widget _buildButton(
      {required VoidCallback? onPressed, required Widget child}) {
    switch (variant) {
      case LoadingButtonVariant.primary:
        return ShadButton(onPressed: onPressed, child: child);
      case LoadingButtonVariant.destructive:
        return ShadButton.destructive(onPressed: onPressed, child: child);
    }
  }

  Widget _buildLoadingContent(BuildContext context) {
    final theme = ShadTheme.of(context);
    final spinnerColor = variant == LoadingButtonVariant.destructive
        ? theme.colorScheme.destructiveForeground
        : theme.colorScheme.primaryForeground;

    final spinner = SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
      ),
    );

    if (loadingText == null) {
      return spinner;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        spinner,
        const SizedBox(width: 12),
        Text(loadingText!),
      ],
    );
  }
}

enum LoadingButtonVariant { primary, destructive }
