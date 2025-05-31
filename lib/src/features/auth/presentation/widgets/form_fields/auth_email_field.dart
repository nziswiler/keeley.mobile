import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthEmailField extends ConsumerWidget {
  const AuthEmailField({
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
      key: const Key(Keys.emailField),
      controller: controller,
      id: Keys.email,
      label: const Text(Strings.email),
      placeholder: const Text(Strings.emailPlaceholder),
      keyboardType: TextInputType.emailAddress,
      enabled: !authState.isLoading,
      validator: validator,
    );
  }
}
