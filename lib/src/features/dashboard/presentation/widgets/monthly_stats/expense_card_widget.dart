import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';

class ExpenseCardWidget extends StatelessWidget {
  const ExpenseCardWidget({
    super.key,
    required this.expenses,
  });

  final double expenses;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_down,
                color: theme.colorScheme.primary,
                size: Sizes.p20,
              ),
              gapW8,
              Text(
                Strings.monthlyExpenses,
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
          gapH8,
          Text(Format.chf(expenses), style: theme.textTheme.h4),
        ],
      ),
    );
  }
}
