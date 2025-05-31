import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard({
    super.key,
    required this.income,
  });

  final double income;

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
                Icons.trending_up,
                color: (theme.colorScheme as KeeleyColorScheme).income,
                size: Sizes.p20,
              ),
              gapW8,
              Text(
                Strings.monthlyIncome,
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
          gapH8,
          Text(
            Format.chf(income),
            style: theme.textTheme.h4.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
