import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthNavigationLink extends StatelessWidget {
  const AuthNavigationLink({
    super.key,
    required this.text,
    required this.route,
  });

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShadButton.link(
        child: Text(text),
        onPressed: () {
          context.go(route);
        },
      ),
    );
  }
}
