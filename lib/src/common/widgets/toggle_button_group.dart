import 'package:flutter/material.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ToggleRadioGroup<T> extends StatelessWidget {
  const ToggleRadioGroup({
    super.key,
    required this.items,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.direction = Axis.horizontal,
  });

  final List<ToggleRadioItem<T>> items;
  final T? groupValue;
  final void Function(T?)? onChanged;
  final String? label;
  final bool enabled;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: ShadTheme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        gapH8,
        Container(
          decoration: BoxDecoration(
              color: ShadTheme.of(context).colorScheme.muted,
              borderRadius: ShadTheme.of(context).radius),
          padding: const EdgeInsets.all(Sizes.p8),
          child: direction == Axis.horizontal
              ? Row(children: _buildButtons(context))
              : Column(children: _buildButtons(context)),
        ),
      ],
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    return items.map((item) {
      final isSelected = groupValue == item.value;

      return direction == Axis.horizontal
          ? Expanded(child: _buildToggleButton(context, item, isSelected))
          : _buildToggleButton(context, item, isSelected);
    }).toList();
  }

  Widget _buildToggleButton(
      BuildContext context, ToggleRadioItem<T> item, bool isSelected) {
    return Padding(
      padding: direction == Axis.horizontal
          ? const EdgeInsets.symmetric(horizontal: Sizes.p4)
          : const EdgeInsets.symmetric(vertical: Sizes.p2),
      child: ShadButton.ghost(
        height: 80,
        onPressed:
            enabled && onChanged != null ? () => onChanged!(item.value) : null,
        decoration: ShadDecoration(
          color: isSelected
              ? ShadTheme.of(context).colorScheme.background
              : Colors.transparent,
          shadows: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.p8, horizontal: Sizes.p4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: 24,
                  color: isSelected
                      ? ShadTheme.of(context).colorScheme.foreground
                      : ShadTheme.of(context).colorScheme.mutedForeground,
                ),
                gapH4
              ],
              Flexible(
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: isSelected
                        ? ShadTheme.of(context).colorScheme.foreground
                        : ShadTheme.of(context).colorScheme.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ToggleRadioItem<T> {
  const ToggleRadioItem({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}
