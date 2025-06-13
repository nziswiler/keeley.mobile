import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/routing/app_router.dart';
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
        sonnerTheme: const ShadSonnerTheme(
          alignment: Alignment.topCenter,
        ),
        cardTheme: const ShadCardTheme(padding: EdgeInsets.all(16)),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const KeeleyColorScheme.dark(),
        sonnerTheme: const ShadSonnerTheme(
          alignment: Alignment.topCenter,
        ),
        cardTheme: const ShadCardTheme(padding: EdgeInsets.all(16)),
      ),
      themeMode: ThemeMode.light,
      appBuilder: (context) {
        final shadTheme = ShadTheme.of(context);
        return MaterialApp.router(
          localizationsDelegates: [
            FirebaseUILocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('de'),
          ],
          routerConfig: goRouter,
          theme: ThemeData(
            scaffoldBackgroundColor: shadTheme.colorScheme.muted,
            canvasColor: shadTheme.colorScheme.muted,
          ),
          builder: (context, child) {
            return ShadAppBuilder(
                child: GoRouterDelegateListener(child: child!));
          },
        );
      },
    );
  }
}
