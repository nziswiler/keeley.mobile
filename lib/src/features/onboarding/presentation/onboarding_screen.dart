import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:keeley/src/routing/app_router.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Strings.onboardingTitle,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            gapH16,
            SvgPicture.asset(
              'assets/time-tracking.svg',
              width: 200,
              height: 200,
              semanticsLabel: Strings.timeTrackingLogo,
            ),
            gapH16,
            state.isLoading
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : ShadButton(
                    onPressed: () async {
                      await ref
                          .read(onboardingControllerProvider.notifier)
                          .completeOnboarding();
                      if (context.mounted) {
                        context.goNamed(AppRoute.signIn.name);
                      }
                    },
                    child: Text(Strings.startTracking),
                  ),
          ],
        ),
      ),
    );
  }
}
