// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey(Keys.scaffoldWithNestedNavigation));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size.width < 450) {
      return ScaffoldWithNavigationBar(
        body: navigationShell,
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      );
    } else {
      return ScaffoldWithNavigationRail(
        body: navigationShell,
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      );
    }
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: body,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colorScheme.card,
          border: Border(
            top: BorderSide(
              color: colorScheme.border,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.house_outlined,
                color: currentIndex == 0
                    ? colorScheme.primary
                    : colorScheme.mutedForeground,
              ),
              selectedIcon: Icon(
                Icons.house,
                color: colorScheme.primary,
              ),
              label: Strings.dashboard,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.list_outlined,
                color: currentIndex == 1
                    ? colorScheme.primary
                    : colorScheme.mutedForeground,
              ),
              selectedIcon: Icon(
                Icons.list,
                color: colorScheme.primary,
              ),
              label: Strings.bookings,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline,
                color: currentIndex == 2
                    ? colorScheme.primary
                    : colorScheme.mutedForeground,
              ),
              selectedIcon: Icon(
                Icons.person,
                color: colorScheme.primary,
              ),
              label: Strings.profile,
            ),
          ],
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.card,
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.card,
              border: Border(
                right: BorderSide(
                  color: colorScheme.border,
                  width: 1,
                ),
              ),
            ),
            child: NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              backgroundColor: Colors.transparent,
              indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
              selectedIconTheme: IconThemeData(
                color: colorScheme.primary,
                size: 24,
              ),
              unselectedIconTheme: IconThemeData(
                color: colorScheme.mutedForeground,
                size: 24,
              ),
              selectedLabelTextStyle: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelTextStyle: TextStyle(
                color: colorScheme.mutedForeground,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: const Icon(Icons.house_outlined),
                  selectedIcon: const Icon(Icons.house),
                  label: Text(Strings.dashboard),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.list_outlined),
                  selectedIcon: const Icon(Icons.list),
                  label: Text(Strings.bookings),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.person_outline),
                  selectedIcon: const Icon(Icons.person),
                  label: Text(Strings.profile),
                ),
              ],
            ),
          ),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
