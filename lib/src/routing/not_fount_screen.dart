import 'package:flutter/material.dart';
import 'package:keeley/src/common_widgets/empty_placeholder_widget.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const EmptyPlaceholderWidget(
        message: 'Uuuups, diese Seite existiert nicht (mehr).',
      ),
    );
  }
}
