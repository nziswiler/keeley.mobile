import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';

class NetBalanceCard extends StatelessWidget {
  const NetBalanceCard({
    super.key,
    required this.netBalance,
  });

  final double netBalance;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isPositive = netBalance >= 0;

    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: theme.colorScheme.foreground,
                size: Sizes.p20,
              ),
              gapW8,
              Text(
                Strings.monthlyBalance,
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
          gapH8,
          Text(
            '${isPositive ? '+ ' : '- '}${Format.chf(netBalance)}',
            style: theme.textTheme.h2.copyWith(
                color: isPositive
                    ? (theme.colorScheme as KeeleyColorScheme).income
                    : theme.colorScheme.primary,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
