import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/features/dashboard/domain/objects/category_expense.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/category_summary/category_icon.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/category_summary/category_icon_utils.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryExpense,
    this.isLast = false,
  });

  final CategoryExpense categoryExpense;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final icon = CategoryIconUtils.getIconForCategory(categoryExpense.category);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            Sizes.p16,
            0,
            isLast ? 0 : Sizes.p8,
          ),
          child: Row(
            children: [
              CategoryIcon(icon: icon),
              gapW12,
              Expanded(
                child: Text(
                  categoryExpense.category.displayName,
                  style: theme.textTheme.p.copyWith(
                    color: theme.colorScheme.foreground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: Sizes.p16),
                child: Text(
                  Format.chf(categoryExpense.amount),
                  style: theme.textTheme.p.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            color: theme.colorScheme.border,
          ),
      ],
    );
  }
}
