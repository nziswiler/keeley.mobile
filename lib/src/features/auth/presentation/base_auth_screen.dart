import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/loading_button.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/presentation/auth_controller.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/alert_dialogs.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

abstract class BaseAuthScreen extends ConsumerStatefulWidget {
  const BaseAuthScreen({super.key});
}

abstract class BaseAuthScreenState<T extends BaseAuthScreen>
    extends ConsumerState<T> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<ShadFormState> formKey;

  double get logoSize => 120.0;
  double get maxFormWidth => 400.0;
  double get horizontalPadding => 24.0;
  double get verticalOffset => -20.0;
  double get logoTopMargin => 180.0;
  double get logoBottomMargin => 48.0;
  String get logoAssetPath => 'assets/logo_min.svg';

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<ShadFormState>();
    onInitState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    onDispose();
    super.dispose();
  }

  Future<void> handleSubmit();
  String get submitButtonText;
  String get authFailedTitle;
  List<Widget> buildFormFields();

  void onInitState() {}
  void onDispose() {}

  String? validateEmail(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return Strings.requiredField;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(trimmedValue)) {
      return Strings.invalidEmail;
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.trim().isEmpty) {
      return Strings.requiredField;
    }
    return null;
  }

  String? validatePasswordWithLength(String value) {
    if (value.trim().isEmpty) {
      return Strings.requiredField;
    }

    if (value.trim().length < 6) {
      return Strings.passwordTooShort;
    }

    return null;
  }

  void handleAuthError(Object error) {
    showExceptionToast(
      context: context,
      title: authFailedTitle,
      exception: error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildScrollableForm(),
      ),
    );
  }

  Widget buildScrollableForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        height: calculateAvailableHeight(),
        child: Center(
          child: Transform.translate(
            offset: Offset(0, verticalOffset),
            child: buildForm(),
          ),
        ),
      ),
    );
  }

  double calculateAvailableHeight() {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
  }

  Widget buildForm() {
    final formFields = buildFormFields();
    final hasSubmitButton = formFields.any((widget) =>
        widget is Consumer ||
        (widget.key is Key && widget.key.toString().contains('Button')));

    return ShadForm(
      key: formKey,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxFormWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildLogo(),
            gapH32,
            ...formFields,
            if (!hasSubmitButton) ...[
              gapH24,
              buildSubmitButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Center(
      child: Container(
        width: logoSize,
        height: logoSize,
        margin: EdgeInsets.only(
          top: logoTopMargin,
          bottom: logoBottomMargin,
        ),
        child: SvgPicture.asset(
          logoAssetPath,
          width: logoSize,
          height: logoSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildEmailField() {
    final authState = ref.watch(authControllerProvider);

    return ShadInputFormField(
      key: const Key(Keys.emailField),
      controller: emailController,
      id: Keys.email,
      label: const Text(Strings.email),
      placeholder: const Text(Strings.emailPlaceholder),
      keyboardType: TextInputType.emailAddress,
      enabled: !authState.isLoading,
      validator: validateEmail,
    );
  }

  Widget buildPasswordField({
    String? Function(String)? validator,
    String? id,
    Key? key,
  }) {
    final authState = ref.watch(authControllerProvider);

    return ShadInputFormField(
      key: key ?? const Key(Keys.passwordField),
      controller: passwordController,
      id: id ?? Keys.password,
      label: const Text(Strings.password),
      placeholder: const Text(Strings.passwordPlaceholder),
      obscureText: true,
      enabled: !authState.isLoading,
      validator: validator ?? validatePassword,
    );
  }

  Widget buildConfirmPasswordField({
    required TextEditingController confirmPasswordController,
    required String? Function(String) validator,
  }) {
    final authState = ref.watch(authControllerProvider);

    return ShadInputFormField(
      key: const Key(Keys.confirmPasswordField),
      controller: confirmPasswordController,
      id: Keys.confirmPassword,
      label: const Text(Strings.confirmPassword),
      placeholder: const Text(Strings.confirmPasswordPlaceholder),
      obscureText: true,
      enabled: !authState.isLoading,
      validator: validator,
    );
  }

  Widget buildSubmitButton() {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authControllerProvider);

        // Listen for auth state changes
        ref.listen(authControllerProvider, (previous, next) {
          if (next.hasError) {
            handleAuthError(next.error!);
          }
        });

        return LoadingButton(
          key: Key(getSubmitButtonKey()),
          onPressed: () async {
            if (!formKey.currentState!.saveAndValidate()) {
              return;
            }
            await handleSubmit();
          },
          isLoading: authState.isLoading,
          child: Text(submitButtonText),
        );
      },
    );
  }

  // Abstract method for submit button key
  String getSubmitButtonKey();
}
