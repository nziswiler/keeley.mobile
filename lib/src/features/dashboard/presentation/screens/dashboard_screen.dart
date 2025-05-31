import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/dashboard_content_widget.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/dashboard_header_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key = const Key(Keys.dashboardScreen)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.primaryForeground,
          title: null,
          elevation: 0,
          toolbarHeight: kToolbarHeight,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            DashboardHeaderWidget(),
            DashboardContentWidget(),
          ],
        ),
      ),
    );
  }
}
