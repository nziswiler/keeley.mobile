import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:keeley/src/features/auth/presentation/screens/base_auth_screen.dart';
import 'package:keeley/src/features/auth/presentation/widgets/auth_navigation_link.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class CustomSignUpScreen extends BaseAuthScreen {
  const CustomSignUpScreen({super.key});

  @override
  ConsumerState<CustomSignUpScreen> createState() => _CustomSignUpScreenState();
}

class _CustomSignUpScreenState extends BaseAuthScreenState<CustomSignUpScreen> {
  late final TextEditingController _confirmPasswordController;

  @override
  double get logoTopMargin => 120.0;

  @override
  void onInitState() {
    super.onInitState();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void onDispose() {
    _confirmPasswordController.dispose();
    super.onDispose();
  }

  @override
  Future<void> handleSubmit() async {
    final authController = ref.read(authControllerProvider.notifier);
    await authController.createUserWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
  }

  @override
  String get submitButtonText => Strings.signUp;

  @override
  String get authFailedTitle => Strings.signUpFailed;

  @override
  String getSubmitButtonKey() => Keys.signUpButton;

  String? _validateConfirmPassword(String value) {
    if (value.trim().isEmpty) {
      return Strings.requiredField;
    }

    if (value.trim() != passwordController.text.trim()) {
      return Strings.passwordsDoNotMatch;
    }

    return null;
  }

  @override
  List<Widget> buildFormFields() {
    return [
      buildEmailField(),
      gapH16,
      buildPasswordField(validator: validatePasswordWithLength),
      gapH16,
      buildConfirmPasswordField(
        confirmPasswordController: _confirmPasswordController,
        validator: _validateConfirmPassword,
      ),
      gapH24,
      buildSubmitButton(),
      gapH16,
      _buildNavigationLink(),
    ];
  }

  Widget _buildNavigationLink() {
    return AuthNavigationLink(
      text: Strings.alreadyHaveAccount,
      route: '/signIn',
    );
  }
}
