import 'package:go_router/go_router.dart';
import 'package:keeley/presentation/pages/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
  ],
);
