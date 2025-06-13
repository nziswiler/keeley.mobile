import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/dashboard_header.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key = const Key(Keys.dashboardScreen)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            DashboardHeader(),
            DashboardContent(),
          ],
        ),
      ),
    );
  }
}
