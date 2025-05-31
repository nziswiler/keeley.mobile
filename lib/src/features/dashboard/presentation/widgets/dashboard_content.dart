import 'package:flutter/material.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/category_summary_card.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/monthly_stats_card.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MonthlyStatsCard(),
          gapH24,
          const CategorySummaryCard(),
          gapH16,
        ],
      ),
    );
  }
}
