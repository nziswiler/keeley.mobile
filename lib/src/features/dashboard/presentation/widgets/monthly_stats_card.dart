import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/error_card.dart';
import 'package:keeley/src/common/widgets/loading_card.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/dashboard/application/dashboard_service.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/monthly_stats/expense_card.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/monthly_stats/income_card.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/monthly_stats/net_balance_card.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class MonthlyStatsCard extends ConsumerWidget {
  const MonthlyStatsCard({super.key = const Key(Keys.monthlyStatsCard)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyStatsAsync = ref.watch(monthlyStatsProvider());

    return monthlyStatsAsync.when(
      data: (stats) {
        return Column(
          children: [
            NetBalanceCard(netBalance: stats.netBalance),
            gapH16,
            Row(
              children: [
                Expanded(
                  child: IncomeCard(income: stats.income),
                ),
                gapW16,
                Expanded(
                  child: ExpenseCard(expenses: stats.expenses),
                ),
              ],
            ),
          ],
        );
      },
      loading: () => const LoadingCard(
        title: Text(Strings.monthlyBalance),
        loadingText: Strings.loadingStats,
      ),
      error: (error, stackTrace) => ErrorCard(
        title: const Text(Strings.monthlyBalance),
        error: error,
        errorTitle: Strings.statsLoadingError,
        onRetry: () => ref.refresh(monthlyStatsProvider()),
      ),
    );
  }
}
