import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/routing/app_router.dart';
import 'package:keeley/src/routing/app_startup.dart';
import 'package:keeley/src/routing/go_router_delegate_listener.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return ShadApp.custom(
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const KeeleyColorScheme.light(),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const KeeleyColorScheme.dark(),
      ),
      themeMode: ThemeMode.light,
      appBuilder: (context) {
        return MaterialApp.router(
          routerConfig: goRouter,
          builder: (context, child) {
            return ShadAppBuilder(
              child: AppStartupWidget(
                onLoaded: (_) => child,
                child: GoRouterDelegateListener(child: child!),
              ),
            );
          },
        );
      },
    );
  }
}
