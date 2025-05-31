import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_screen_controller.g.dart';

@riverpod
class DashboardScreenController extends _$DashboardScreenController {
  @override
  FutureOr<void> build() {}

  Future<void> refreshDashboard() async {
    state = const AsyncLoading();

    try {
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
