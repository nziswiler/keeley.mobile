import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/loading_button.dart';
import 'package:keeley/src/features/auth/presentation/controllers/auth_controller.dart';

class AuthSubmitButton extends ConsumerWidget {
  const AuthSubmitButton({
    super.key,
    required this.buttonKey,
    required this.onPressed,
    required this.onError,
    required this.text,
  });

  final String buttonKey;
  final Future<void> Function() onPressed;
  final void Function(Object) onError;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    // Listen for auth state changes
    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        onError(next.error!);
      }
    });

    return LoadingButton(
      key: Key(buttonKey),
      onPressed: onPressed,
      isLoading: authState.isLoading,
      child: Text(text),
    );
  }
}
