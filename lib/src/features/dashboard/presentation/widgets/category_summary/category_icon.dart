import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.muted,
        borderRadius: BorderRadius.circular(Sizes.p12),
      ),
      padding: const EdgeInsets.all(Sizes.p12),
      child: Icon(
        icon,
        color: theme.colorScheme.mutedForeground,
        size: Sizes.p20,
      ),
    );
  }
}
