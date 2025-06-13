import 'package:keeley/src/features/dashboard/domain/objects/monthly_stats.dart';
import 'package:keeley/src/features/dashboard/domain/objects/category_expense.dart';

abstract class IDashboardService {
  Future<MonthlyStats> getMonthlyStatsAsync({
    required String userId,
    required DateTime month,
  });

  Future<List<CategoryExpense>> getMonthlyExpensesByCategoryAsync(
    String userId,
    DateTime month,
  );
}
