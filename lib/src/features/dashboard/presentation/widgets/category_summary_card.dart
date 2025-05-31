import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/empty_state_card.dart';
import 'package:keeley/src/common/widgets/error_card.dart';
import 'package:keeley/src/common/widgets/loading_card.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/features/dashboard/application/dashboard_service.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/category_summary/category_item_widget.dart';

class CategorySummaryCard extends ConsumerWidget {
  const CategorySummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryExpensesAsync = ref.watch(categoryExpensesProvider());

    return categoryExpensesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
          return const EmptyStateCard(
            title: Text(Strings.categorySummaryTitle),
            icon: Icons.category_outlined,
            emptyTitle: Strings.noCategoriesTitle,
            emptyMessage: Strings.noCategoriesMessage,
          );
        }

        return ShadCard(
          title: const Text(Strings.categorySummaryTitle),
          child: Column(
            children: categories
                .asMap()
                .entries
                .map((entry) => CategoryItemWidget(
                      categoryExpense: entry.value,
                      isLast: entry.key == categories.length - 1,
                    ))
                .toList(),
          ),
        );
      },
      loading: () => const LoadingCard(
        title: Text(Strings.categorySummaryTitle),
        height: 200,
        loadingText: Strings.loadingCategories,
      ),
      error: (error, stackTrace) => ErrorCard(
        title: const Text(Strings.categorySummaryTitle),
        error: error,
        height: 200,
        errorTitle: Strings.loadingCategoriesError,
        onRetry: () => ref.refresh(categoryExpensesProvider()),
      ),
    );
  }
}
