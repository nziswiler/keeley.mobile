import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class Greeting extends ConsumerWidget {
  const Greeting({super.key});

  String _getTimeBasedGreeting(String firstName) {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Guten Morgen, $firstName! 😎';
    } else if (hour >= 12 && hour < 17) {
      return 'Hey, $firstName! 👋';
    } else if (hour >= 17 && hour < 24) {
      return 'Hi, $firstName! ✨';
    } else {
      return '$firstName, noch wach? 🌜';
    }
  }

  String _getTimeBasedSubtext() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Zeit, die Welt zu erobern!';
    } else if (hour >= 12 && hour < 17) {
      return 'Lass uns den Nachmittag rocken!';
    } else if (hour >= 17 && hour < 24) {
      return 'Noch Energie für ein paar kreative Ideen?';
    } else {
      return 'Die besten Einfälle kommen oft spät!';
    }
  }

  String _getUserFirstName(String? displayName, String? email) {
    String fullName = '';

    if (displayName != null && displayName.isNotEmpty) {
      fullName = displayName;
    } else if (email != null && email.isNotEmpty) {
      final namePart = email.split('@').first;
      fullName = namePart.substring(0, 1).toUpperCase() + namePart.substring(1);
    } else {
      return 'Fellow Hustler';
    }

    final firstName = fullName.split(' ').first;
    return firstName;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final authState = ref.watch(authStateChangesProvider);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: authState.when(
        data: (user) {
          final firstName = _getUserFirstName(user?.displayName, user?.email);
          final greeting = _getTimeBasedGreeting(firstName);
          final subtext = _getTimeBasedSubtext();

          return _HeaderContent(
            greeting: greeting,
            subtext: subtext,
            theme: theme,
          );
        },
        loading: () => _LoadingHeader(theme: theme),
        error: (error, stack) => _ErrorHeader(theme: theme),
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent({
    required this.greeting,
    required this.subtext,
    required this.theme,
  });

  final String greeting;
  final String subtext;
  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: theme.textTheme.h1.copyWith(
            color: theme.colorScheme.primaryForeground,
            fontWeight: FontWeight.bold,
          ),
        ),
        gapH4,
        Text(
          subtext,
          style: theme.textTheme.large.copyWith(
            color: theme.colorScheme.primaryForeground.withValues(alpha: 0.9),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

/// Loading-State für den Header
class _LoadingHeader extends StatelessWidget {
  const _LoadingHeader({required this.theme});

  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: CircularProgressIndicator(
          color: theme.colorScheme.primaryForeground,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

/// Error-State für den Header (Fallback)
class _ErrorHeader extends StatelessWidget {
  const _ErrorHeader({required this.theme});

  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    return _HeaderContent(
      greeting: 'Hey Fellow Hustler! 👋',
      subtext: 'Zeit, die Welt zu erobern!',
      theme: theme,
    );
  }
}
