import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/presentation/auth_controller.dart';
import 'package:keeley/src/features/auth/presentation/base_auth_screen.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CustomSignInScreen extends BaseAuthScreen {
  const CustomSignInScreen({super.key});

  @override
  ConsumerState<CustomSignInScreen> createState() => _CustomSignInScreenState();
}

class _CustomSignInScreenState extends BaseAuthScreenState<CustomSignInScreen> {
  @override
  Future<void> handleSubmit() async {
    final authController = ref.read(authControllerProvider.notifier);
    await authController.sigInInUserWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
  }

  @override
  String get submitButtonText => Strings.signIn;

  @override
  String get submitLoadingText => Strings.signInLoading;

  @override
  String get authFailedTitle => Strings.signInFailed;

  @override
  String getSubmitButtonKey() => Keys.signInButton;

  @override
  List<Widget> buildFormFields() {
    return [
      buildEmailField(),
      gapH16,
      buildPasswordField(),
      gapH24,
      buildSubmitButton(),
      gapH16,
      buildNavigationLink(),
    ];
  }

  Widget buildNavigationLink() {
    return Center(
        child: ShadButton.link(
      child: const Text('Noch kein Konto? Jetzt registrieren'),
      onPressed: () {
        context.go('/signUp');
      },
    ));
  }
}
