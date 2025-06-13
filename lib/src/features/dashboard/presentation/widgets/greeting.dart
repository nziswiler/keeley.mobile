import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/greeting/greeting_content.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/greeting/greeting_loading.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/greeting/greeting_utils.dart';
import 'package:keeley/src/features/dashboard/presentation/widgets/greeting/greeting_error.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class Greeting extends ConsumerWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final authState = ref.watch(authStateChangesProvider);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      padding: const EdgeInsets.fromLTRB(
        Sizes.p16,
        0,
        Sizes.p16,
        0,
      ),
      child: authState.when(
        data: (user) {
          final firstName = GreetingUtils.extractFirstName(
            user?.displayName,
            user?.email,
          );
          final greeting = GreetingUtils.getTimeBasedGreeting(firstName);
          final subtext = GreetingUtils.getTimeBasedSubtext();

          return GreetingContent(
            greeting: greeting,
            subtext: subtext,
          );
        },
        loading: () => const GreetingLoading(),
        error: (error, stack) => const GreetingError(),
      ),
    );
  }
}
