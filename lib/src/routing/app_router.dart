import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/auth/presentation/custom_profile_screen.dart';
import 'package:keeley/src/features/auth/presentation/custom_sign_in_screen.dart';
import 'package:keeley/src/features/bookings/presentation/bookings_screen.dart';
import 'package:keeley/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:keeley/src/routing/go_router_refresh_stream.dart';
import 'package:keeley/src/routing/not_fount_screen.dart';
import 'package:keeley/src/routing/scaffold_with_nested_navigation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashboardNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashboard');
final _bookingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'bookings');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

enum AppRoute {
  signIn,
  dashboard,
  bookings,
  profile,
}

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final path = state.uri.path;

      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (path.startsWith('/signIn')) {
          return '/dashboard';
        }
      } else {
        if (!path.startsWith('/signIn')) {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: CustomSignInScreen(),
        ),
      ),
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                name: AppRoute.dashboard.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _bookingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/bookings',
                name: AppRoute.bookings.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: BookingsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CustomProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
