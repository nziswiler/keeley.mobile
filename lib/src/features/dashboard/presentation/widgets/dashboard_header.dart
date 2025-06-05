import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/greeting.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key = const Key(Keys.dashboardHeader),
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      padding: EdgeInsets.fromLTRB(
        Sizes.p16,
        Sizes.p16,
        Sizes.p16,
        Sizes.p32,
      ),
      child: const Greeting(),
    );
  }
}
