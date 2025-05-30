import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/category_summary_card.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/monthly_stats_card.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/greeting.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.primaryForeground,
          title: null,
          elevation: 0,
          toolbarHeight: kToolbarHeight,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Greeting(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MonthlyStatsCard(),
                  gapH24,
                  const CategorySummaryCard(),
                  gapH16,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
