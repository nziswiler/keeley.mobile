import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/auth/domain/exceptions/user_not_authenticated_exception.dart';
import 'package:keeley/src/features/dashboard/application/dashboard_service.dart';
import 'package:keeley/src/features/dashboard/domain/objects/monthly_stats.dart';
import 'package:keeley/src/features/dashboard/domain/objects/category_expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_screen_controller.g.dart';

@riverpod
class DashboardScreenController extends _$DashboardScreenController {
  @override
  DashboardState build() {
    return const DashboardState();
  }

  Future<void> refreshDashboard() async {
    state = state.copyWith(isRefreshing: true);

    try {
      // Refresh logic can be handled by the calling widgets
      // by invalidating their respective providers
      state = state.copyWith(isRefreshing: false);
    } catch (e) {
      state = state.copyWith(isRefreshing: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  Future<MonthlyStats> getMonthlyStats({DateTime? month}) async {
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (user == null) {
      throw UserNotAuthenticatedException();
    }

    final service = ref.read(dashboardServiceProvider);
    final targetMonth = month ?? DateTime.now();

    return service.getMonthlyStats(
      userId: user.uid,
      month: targetMonth,
    );
  }

  Future<List<CategoryExpense>> getCategoryExpenses(
      {DateTime? month, int limit = 10}) async {
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final service = ref.read(dashboardServiceProvider);
    final targetMonth = month ?? DateTime.now();

    return service.getCategoryExpenses(
      userId: user.uid,
      month: targetMonth,
      limit: limit,
    );
  }
}

class DashboardState {
  const DashboardState({
    this.isRefreshing = false,
    this.error,
  });

  final bool isRefreshing;
  final String? error;

  DashboardState copyWith({
    bool? isRefreshing,
    String? error,
  }) {
    return DashboardState(
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error ?? this.error,
    );
  }
}
