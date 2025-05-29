import 'package:flutter/material.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
              strokeWidth: 2,
            ),
          ),
          gapH16,
          Text(
            Strings.loading,
            style: theme.textTheme.muted.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
