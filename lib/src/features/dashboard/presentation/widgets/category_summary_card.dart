import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/empty_state_card.dart';
import 'package:keeley/src/common/widgets/error_card.dart';
import 'package:keeley/src/common/widgets/loading_card.dart';
import 'package:keeley/src/features/dashboard/domain/objects/category_expense.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/features/dashboard/application/dashboard_service.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/format.dart';

class CategorySummaryCard extends ConsumerWidget {
  const CategorySummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryExpensesAsync = ref.watch(categoryExpensesProvider());

    return categoryExpensesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
          return const EmptyStateCard(
            title: Text('Ausgaben nach Kategorien'),
            icon: Icons.category_outlined,
            emptyTitle: 'Keine Ausgaben vorhanden',
            emptyMessage:
                'Bisher wurden keine Ausgaben in diesem Monat erfasst.',
          );
        }

        return ShadCard(
          title: const Text('Ausgaben nach Kategorien'),
          child: Column(
            children: categories
                .asMap()
                .entries
                .map((entry) => _CategoryItem(
                      categoryExpense: entry.value,
                      isLast: entry.key == categories.length - 1,
                    ))
                .toList(),
          ),
        );
      },
      loading: () => const LoadingCard(
        title: Text('Ausgaben nach Kategorien'),
        height: 200,
        loadingText: 'Lade Kategorien...',
      ),
      error: (error, stackTrace) => ErrorCard(
        title: const Text('Ausgaben nach Kategorien'),
        error: error,
        height: 200,
        errorTitle: 'Fehler beim Laden der Kategorien',
        onRetry: () => ref.refresh(categoryExpensesProvider()),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.categoryExpense,
    this.isLast = false,
  });

  final CategoryExpense categoryExpense;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final icon = _getIconForCategory(categoryExpense.category);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, isLast ? 0 : 8),
          child: Row(
            children: [
              _CategoryIcon(icon: icon, theme: theme),
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
                padding: const EdgeInsets.only(right: 16),
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

  IconData _getIconForCategory(BookingCategory category) {
    switch (category) {
      case BookingCategory.housing:
        return Icons.home_outlined;
      case BookingCategory.groceries:
        return Icons.shopping_cart_outlined;
      case BookingCategory.transport:
        return Icons.directions_car_outlined;
      case BookingCategory.leisure:
        return Icons.sports_esports_outlined;
      case BookingCategory.salary:
        return Icons.attach_money;
      case BookingCategory.other:
        return Icons.category_outlined;
    }
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({
    required this.icon,
    required this.theme,
  });

  final IconData icon;
  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.muted,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Icon(
        icon,
        color: theme.colorScheme.mutedForeground,
        size: 20,
      ),
    );
  }
}
