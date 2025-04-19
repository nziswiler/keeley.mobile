// lib/app/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/pages/dashboard/dashboard_page.dart';
import '../presentation/pages/bookings/bookings_page.dart';
import '../presentation/pages/profile/profile_page.dart';
import '../presentation/widgets/app_scaffold.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/bookings',
          builder: (context, state) => const BookingsPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);
