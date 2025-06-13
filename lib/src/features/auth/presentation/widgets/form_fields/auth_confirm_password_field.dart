import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthConfirmPasswordField extends ConsumerWidget {
  const AuthConfirmPasswordField({
    super.key,
    required this.controller,
    required this.validator,
  });

  final TextEditingController controller;
  final String? Function(String) validator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return ShadInputFormField(
      key: const Key(Keys.confirmPasswordField),
      controller: controller,
      id: Keys.confirmPassword,
      label: const Text(Strings.confirmPassword),
      placeholder: const Text(Strings.confirmPasswordPlaceholder),
      obscureText: true,
      enabled: !authState.isLoading,
      validator: validator,
    );
  }
}
