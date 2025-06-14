import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/auth/data/auth_repository.dart';
import 'package:keeley/src/features/auth/domain/exceptions/user_not_authenticated_exception.dart';
import 'package:keeley/src/features/bookings/data/booking_repository.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_type.dart';
import 'package:keeley/src/features/bookings/domain/objects/booking_category.dart';
import 'package:keeley/src/features/dashboard/domain/objects/category_expense.dart';
import 'package:keeley/src/features/dashboard/domain/objects/monthly_stats.dart';
import 'package:keeley/src/features/dashboard/domain/services/i_dashboard_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_service.g.dart';

class DashboardService implements IDashboardService {
  const DashboardService(this._bookingRepository);
  final BookingRepository _bookingRepository;

  @override
  Future<MonthlyStats> getMonthlyStatsAsync({
    required String userId,
    required DateTime month,
  }) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    final bookings = await _bookingRepository.getBookingsInDateRange(
      userId: userId,
      startDate: startOfMonth,
      endDate: endOfMonth,
    );

    double totalIncome = 0;
    double totalExpenses = 0;

    for (final booking in bookings) {
      if (booking.type == BookingType.income) {
        totalIncome += booking.amount;
      } else {
        totalExpenses += booking.amount;
      }
    }

    return MonthlyStats(
      income: totalIncome,
      expenses: totalExpenses,
      netBalance: totalIncome - totalExpenses,
    );
  }

  @override
  Future<List<CategoryExpense>> getMonthlyExpensesByCategoryAsync(
    String userId,
    DateTime month,
  ) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    final bookings = await _bookingRepository.getBookingsInDateRange(
      userId: userId,
      startDate: startOfMonth,
      endDate: endOfMonth,
    );

    final categoryMap = <BookingCategory, double>{
      BookingCategory.housing: 0.0,
      BookingCategory.groceries: 0.0,
      BookingCategory.transport: 0.0,
      BookingCategory.leisure: 0.0,
      BookingCategory.other: 0.0,
    };

    for (final booking in bookings) {
      if (booking.type == BookingType.expense) {
        final category = booking.category ?? BookingCategory.other;
        if (category != BookingCategory.salary &&
            categoryMap.containsKey(category)) {
          categoryMap[category] = (categoryMap[category] ?? 0) + booking.amount;
        }
      }
    }

    final categoryExpenses = categoryMap.entries
        .map((entry) => CategoryExpense(
              category: entry.key,
              amount: entry.value,
            ))
        .toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));

    return categoryExpenses;
  }
}

@Riverpod(keepAlive: true)
IDashboardService dashboardService(Ref ref) {
  return DashboardService(ref.watch(bookingRepositoryProvider));
}

@riverpod
Future<MonthlyStats> monthlyStats(Ref ref, {DateTime? month}) async {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw UserNotAuthenticatedException();
  }

  final service = ref.watch(dashboardServiceProvider);
  final targetMonth = month ?? DateTime.now();
  return service.getMonthlyStatsAsync(userId: user.uid, month: targetMonth);
}

@riverpod
Future<List<CategoryExpense>> categoryExpenses(Ref ref) async {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw UserNotAuthenticatedException();
  }

  final service = ref.watch(dashboardServiceProvider);
  final currentMonth = DateTime.now();
  return service.getMonthlyExpensesByCategoryAsync(user.uid, currentMonth);
}
