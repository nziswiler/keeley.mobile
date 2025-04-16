import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'config/routes/app_router.dart';

void main() {
  runApp(
    // Wir umschließen die gesamte App mit einem ProviderScope,
    // damit Riverpod für alle Widgets verfügbar ist
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadApp(
      builder: (lightTheme, darkTheme) => MaterialApp.router(
        title: 'Keeley',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
