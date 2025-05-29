import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.loadingText,
    this.disabled = false,
    this.variant = LoadingButtonVariant.primary,
    this.size = ShadButtonSize.regular,
    this.loadingWidget,
  });

  final VoidCallback? onPressed;

  final Widget child;

  final bool isLoading;

  final String? loadingText;

  final bool disabled;

  final LoadingButtonVariant variant;

  final ShadButtonSize size;

  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    final isInteractable = !isLoading && !disabled && onPressed != null;

    return _buildButton(
      onPressed: isInteractable ? onPressed : null,
      child: isLoading ? _buildLoadingContent(context) : child,
    );
  }

  Widget _buildButton(
      {required VoidCallback? onPressed, required Widget child}) {
    switch (variant) {
      case LoadingButtonVariant.primary:
        return ShadButton(
          onPressed: onPressed,
          size: size,
          child: child,
        );
      case LoadingButtonVariant.secondary:
        return ShadButton.secondary(
          onPressed: onPressed,
          size: size,
          child: child,
        );
      case LoadingButtonVariant.outline:
        return ShadButton.outline(
          onPressed: onPressed,
          size: size,
          child: child,
        );
      case LoadingButtonVariant.destructive:
        return ShadButton.destructive(
          onPressed: onPressed,
          size: size,
          child: child,
        );
      case LoadingButtonVariant.ghost:
        return ShadButton.ghost(
          onPressed: onPressed,
          size: size,
          child: child,
        );
    }
  }

  Widget _buildLoadingContent(BuildContext context) {
    if (loadingWidget != null) {
      return loadingWidget!;
    }

    final spinner = SizedBox(
      width: _getSpinnerSize(),
      height: _getSpinnerSize(),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          _getSpinnerColor(context),
        ),
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

  double _getSpinnerSize() {
    switch (size) {
      case ShadButtonSize.sm:
        return 12.0;
      case ShadButtonSize.regular:
        return 16.0;
      case ShadButtonSize.lg:
        return 20.0;
    }
  }

  Color _getSpinnerColor(BuildContext context) {
    final theme = ShadTheme.of(context);

    switch (variant) {
      case LoadingButtonVariant.primary:
      case LoadingButtonVariant.destructive:
        return theme.colorScheme.primaryForeground;
      case LoadingButtonVariant.secondary:
        return theme.colorScheme.secondaryForeground;
      case LoadingButtonVariant.outline:
      case LoadingButtonVariant.ghost:
        return theme.colorScheme.foreground;
    }
  }
}

enum LoadingButtonVariant {
  primary,
  secondary,
  outline,
  destructive,
  ghost,
}

extension LoadingButtonFactory on LoadingButton {
  static LoadingButton primary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    bool isLoading = false,
    String? loadingText,
    bool disabled = false,
    ShadButtonSize size = ShadButtonSize.regular,
    Widget? loadingWidget,
  }) =>
      LoadingButton(
        key: key,
        onPressed: onPressed,
        isLoading: isLoading,
        loadingText: loadingText,
        disabled: disabled,
        variant: LoadingButtonVariant.primary,
        size: size,
        loadingWidget: loadingWidget,
        child: child,
      );

  static LoadingButton destructive({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    bool isLoading = false,
    String? loadingText,
    bool disabled = false,
    ShadButtonSize size = ShadButtonSize.regular,
    Widget? loadingWidget,
  }) =>
      LoadingButton(
        key: key,
        onPressed: onPressed,
        isLoading: isLoading,
        loadingText: loadingText,
        disabled: disabled,
        variant: LoadingButtonVariant.destructive,
        size: size,
        loadingWidget: loadingWidget,
        child: child,
      );

  static LoadingButton outline({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    bool isLoading = false,
    String? loadingText,
    bool disabled = false,
    ShadButtonSize size = ShadButtonSize.regular,
    Widget? loadingWidget,
  }) =>
      LoadingButton(
        key: key,
        onPressed: onPressed,
        isLoading: isLoading,
        loadingText: loadingText,
        disabled: disabled,
        variant: LoadingButtonVariant.outline,
        size: size,
        loadingWidget: loadingWidget,
        child: child,
      );
}
