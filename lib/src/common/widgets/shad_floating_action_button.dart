import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/strings.dart';

class ShadFloatingActionButton extends StatelessWidget {
  const ShadFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.tooltip,
    this.size = ShadFloatingActionButtonSize.normal,
    this.variant = ShadFloatingActionButtonVariant.primary,
    this.heroTag,
    this.elevation,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final String? tooltip;
  final ShadFloatingActionButtonSize size;
  final ShadFloatingActionButtonVariant variant;
  final Object? heroTag;
  final double? elevation;

  factory ShadFloatingActionButton.add({
    Key? key,
    required VoidCallback? onPressed,
    String? tooltip,
    ShadFloatingActionButtonSize size = ShadFloatingActionButtonSize.normal,
    Object? heroTag,
  }) {
    return ShadFloatingActionButton(
      key: key,
      onPressed: onPressed,
      tooltip: tooltip ?? Strings.add,
      size: size,
      heroTag: heroTag,
      child: const Icon(Icons.add),
    );
  }

  factory ShadFloatingActionButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    String? tooltip,
    ShadFloatingActionButtonSize size = ShadFloatingActionButtonSize.normal,
    Object? heroTag,
  }) {
    return ShadFloatingActionButton(
      key: key,
      onPressed: onPressed,
      tooltip: tooltip,
      size: size,
      variant: ShadFloatingActionButtonVariant.secondary,
      heroTag: heroTag,
      child: child,
    );
  }

  factory ShadFloatingActionButton.outline({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    String? tooltip,
    ShadFloatingActionButtonSize size = ShadFloatingActionButtonSize.normal,
    Object? heroTag,
  }) {
    return ShadFloatingActionButton(
      key: key,
      onPressed: onPressed,
      tooltip: tooltip,
      size: size,
      variant: ShadFloatingActionButtonVariant.outline,
      heroTag: heroTag,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    final buttonSize = _getButtonSize();
    final colors = _getColors(colorScheme);
    final iconSize = _getIconSize();

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: FloatingActionButton(
        onPressed: onPressed,
        tooltip: tooltip,
        heroTag: heroTag,
        elevation: elevation ?? _getElevation(),
        highlightElevation: (elevation ?? _getElevation()) + 2,
        backgroundColor: colors.background,
        foregroundColor: colors.foreground,
        splashColor: colors.splash,
        focusColor: colors.focus,
        hoverColor: colors.hover,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonSize / 2),
          side: variant == ShadFloatingActionButtonVariant.outline
              ? BorderSide(
                  color: colorScheme.border,
                  width: 1,
                )
              : BorderSide.none,
        ),
        child: IconTheme(
          data: IconThemeData(
            size: iconSize,
            color: colors.foreground,
          ),
          child: child,
        ),
      ),
    );
  }

  double _getButtonSize() {
    switch (size) {
      case ShadFloatingActionButtonSize.small:
        return 40.0;
      case ShadFloatingActionButtonSize.normal:
        return 56.0;
      case ShadFloatingActionButtonSize.large:
        return 64.0;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ShadFloatingActionButtonSize.small:
        return 20.0;
      case ShadFloatingActionButtonSize.normal:
        return 24.0;
      case ShadFloatingActionButtonSize.large:
        return 28.0;
    }
  }

  double _getElevation() {
    switch (variant) {
      case ShadFloatingActionButtonVariant.primary:
        return 6.0;
      case ShadFloatingActionButtonVariant.secondary:
        return 4.0;
      case ShadFloatingActionButtonVariant.outline:
        return 2.0;
    }
  }

  _FABColors _getColors(ShadColorScheme colorScheme) {
    switch (variant) {
      case ShadFloatingActionButtonVariant.primary:
        return _FABColors(
          background: colorScheme.primary,
          foreground: colorScheme.primaryForeground,
          hover: colorScheme.primary.withValues(alpha: 0.9),
          focus: colorScheme.primary.withValues(alpha: 0.8),
          splash: colorScheme.primaryForeground.withValues(alpha: 0.1),
        );
      case ShadFloatingActionButtonVariant.secondary:
        return _FABColors(
          background: colorScheme.secondary,
          foreground: colorScheme.secondaryForeground,
          hover: colorScheme.secondary.withValues(alpha: 0.9),
          focus: colorScheme.secondary.withValues(alpha: 0.8),
          splash: colorScheme.secondaryForeground.withValues(alpha: 0.1),
        );
      case ShadFloatingActionButtonVariant.outline:
        return _FABColors(
          background: colorScheme.background,
          foreground: colorScheme.foreground,
          hover: colorScheme.accent.withValues(alpha: 0.1),
          focus: colorScheme.accent.withValues(alpha: 0.2),
          splash: colorScheme.foreground.withValues(alpha: 0.1),
        );
    }
  }
}

class _FABColors {
  const _FABColors({
    required this.background,
    required this.foreground,
    required this.hover,
    required this.focus,
    required this.splash,
  });

  final Color background;
  final Color foreground;
  final Color hover;
  final Color focus;
  final Color splash;
}

enum ShadFloatingActionButtonSize {
  small,
  normal,
  large,
}

enum ShadFloatingActionButtonVariant {
  primary,
  secondary,
  outline,
}
