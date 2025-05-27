// lib/src/common_widgets/loading_button.dart
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// A reusable button widget that shows a loading state with spinner
class LoadingButton extends StatelessWidget {
  /// Creates a loading button
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

  /// Callback when button is pressed (only called when not loading/disabled)
  final VoidCallback? onPressed;

  /// Child widget to display when not loading
  final Widget child;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Text to show when loading (optional)
  final String? loadingText;

  /// Whether the button is disabled
  final bool disabled;

  /// Button variant/style
  final LoadingButtonVariant variant;

  /// Button size
  final ShadButtonSize size;

  /// Custom loading widget (optional)
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    final isInteractable = !isLoading && !disabled && onPressed != null;

    return _buildButton(
      onPressed: isInteractable ? onPressed : null,
      child: isLoading ? _buildLoadingContent(context) : child,
    );
  }

  /// Builds the appropriate button based on variant
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

  /// Builds the loading content with spinner and optional text
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

  /// Gets the appropriate spinner size based on button size
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

  /// Gets the appropriate spinner color based on variant
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

/// Available button variants for the loading button
enum LoadingButtonVariant {
  primary,
  secondary,
  outline,
  destructive,
  ghost,
}

/// Extension methods for easier usage
extension LoadingButtonX on LoadingButton {
  /// Creates a primary loading button
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
        child: child,
        isLoading: isLoading,
        loadingText: loadingText,
        disabled: disabled,
        variant: LoadingButtonVariant.primary,
        size: size,
        loadingWidget: loadingWidget,
      );

  /// Creates a destructive loading button
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
        child: child,
        isLoading: isLoading,
        loadingText: loadingText,
        disabled: disabled,
        variant: LoadingButtonVariant.destructive,
        size: size,
        loadingWidget: loadingWidget,
      );

  /// Creates an outline loading button
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
        child: child,
        isLoading: isLoading,
        loadingText: loadingText,
        disabled: disabled,
        variant: LoadingButtonVariant.outline,
        size: size,
        loadingWidget: loadingWidget,
      );
}
