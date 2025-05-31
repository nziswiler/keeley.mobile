import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthPasswordField extends ConsumerWidget {
  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.validator,
    this.id,
    this.fieldKey,
  });

  final TextEditingController controller;
  final String? Function(String) validator;
  final String? id;
  final Key? fieldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return ShadInputFormField(
      key: fieldKey ?? const Key(Keys.passwordField),
      controller: controller,
      id: id ?? Keys.password,
      label: const Text(Strings.password),
      placeholder: const Text(Strings.passwordPlaceholder),
      obscureText: true,
      enabled: !authState.isLoading,
      validator: validator,
    );
  }
}
