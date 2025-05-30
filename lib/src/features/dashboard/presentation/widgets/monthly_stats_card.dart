import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/error_card.dart';
import 'package:keeley/src/common/widgets/loading_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/features/dashboard/application/dashboard_service.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';

class MonthlyStatsCard extends ConsumerWidget {
  const MonthlyStatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyStatsAsync = ref.watch(monthlyStatsProvider());
    final theme = ShadTheme.of(context);

    return monthlyStatsAsync.when(
      data: (stats) {
        return Column(
          children: [
            ShadCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        stats.netBalance >= 0
                            ? Icons.account_balance_wallet
                            : Icons.trending_down,
                        color: theme.colorScheme.foreground,
                        size: 20,
                      ),
                      gapW8,
                      Text(
                        'Monatssaldo',
                        style: theme.textTheme.small.copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  gapH8,
                  Text(
                    '${stats.netBalance >= 0 ? '+' : ''}${Format.chf(stats.netBalance)}',
                    style: theme.textTheme.h2.copyWith(
                      color: stats.netBalance >= 0
                          ? (theme.colorScheme as KeeleyColorScheme).income
                          : theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            gapH16,
            Row(
              children: [
                Expanded(
                  child: _IncomeCard(income: stats.income),
                ),
                gapW16,
                Expanded(
                  child: _ExpenseCard(expenses: stats.expenses),
                ),
              ],
            ),
          ],
        );
      },
      loading: () => const LoadingCard(
        title: Text('Monatliche Übersicht'),
        height: 200,
        loadingText: 'Lade Statistiken...',
      ),
      error: (error, stackTrace) => ErrorCard(
        title: const Text('Monatliche Übersicht'),
        error: error,
        height: 200,
        errorTitle: 'Fehler beim Laden der Statistiken',
        onRetry: () => ref.refresh(monthlyStatsProvider()),
      ),
    );
  }
}

class _IncomeCard extends StatelessWidget {
  const _IncomeCard({required this.income});

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
                size: 20,
              ),
              gapW8,
              Text(
                'Einnahmen',
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

class _ExpenseCard extends StatelessWidget {
  const _ExpenseCard({required this.expenses});

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
                size: 20,
              ),
              gapW8,
              Text(
                'Ausgaben',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
          gapH8,
          Text(
            Format.chf(expenses),
            style: theme.textTheme.h4.copyWith(
              color: theme.colorScheme.foreground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
