import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: KeeleyApp(),
    ),
  );
}

class KeeleyApp extends ConsumerWidget {
  const KeeleyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadApp(
      title: 'Keeley',
      debugShowCheckedModeBanner: false,
    );
  }
}
