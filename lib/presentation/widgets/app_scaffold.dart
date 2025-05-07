import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({required this.child, super.key});

  static const _tabs = [
    ('/dashboard', Icons.dashboard, 'Dashboard'),
    ('/bookings', Icons.list_alt, 'Buchungen'),
    ('/profile', Icons.person, 'Profil'),
  ];

  int _currentIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final index = _tabs.indexWhere((tab) => location.startsWith(tab.$1));
    return index >= 0 ? index : 0; // Fallback auf Tab 0 bei ungültiger Route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        onTap: (index) => context.go(_tabs[index].$1),
        items: _tabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.$2),
                label: tab.$3,
              ),
            )
            .toList(),
      ),
    );
  }
}
