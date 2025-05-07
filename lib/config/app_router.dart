import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../presentation/pages/login_page.dart';
import '../presentation/pages/dashboard/dashboard_page.dart';
import '../presentation/pages/bookings/bookings_page.dart';
import '../presentation/pages/profile/profile_page.dart';
import '../presentation/widgets/app_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isLogin = state.uri.toString().startsWith('/login');

    if (!isLoggedIn && !isLogin) return '/login';
    if (isLoggedIn && isLogin) return '/dashboard';
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
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
