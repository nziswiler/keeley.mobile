import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/presentation/widgets/widgets.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/toasts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

abstract class BaseAuthScreen extends ConsumerStatefulWidget {
  const BaseAuthScreen({super.key});
}

abstract class BaseAuthScreenState<T extends BaseAuthScreen>
    extends ConsumerState<T> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<ShadFormState> formKey;

  double get logoSize => Sizes.p120;
  double get maxFormWidth => Sizes.p400;
  double get horizontalPadding => Sizes.p24;
  double get verticalOffset => -Sizes.p20;
  double get logoTopMargin => Sizes.p180;
  double get logoBottomMargin => Sizes.p48;
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
    final hasSubmitButton =
        formFields.any((widget) => widget is AuthSubmitButton);

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
    return AuthLogoWidget(
      size: logoSize,
      topMargin: logoTopMargin,
      bottomMargin: logoBottomMargin,
      assetPath: logoAssetPath,
    );
  }

  Widget buildEmailField() {
    return AuthEmailField(
      controller: emailController,
      validator: validateEmail,
    );
  }

  Widget buildPasswordField({
    String? Function(String)? validator,
    String? id,
    Key? key,
  }) {
    return AuthPasswordField(
      controller: passwordController,
      validator: validator ?? validatePassword,
      id: id,
      fieldKey: key,
    );
  }

  Widget buildConfirmPasswordField({
    required TextEditingController confirmPasswordController,
    required String? Function(String) validator,
  }) {
    return AuthConfirmPasswordField(
      controller: confirmPasswordController,
      validator: validator,
    );
  }

  Widget buildSubmitButton() {
    return AuthSubmitButton(
      buttonKey: getSubmitButtonKey(),
      onPressed: () async {
        if (!formKey.currentState!.saveAndValidate()) {
          return;
        }
        await handleSubmit();
      },
      onError: handleAuthError,
      text: submitButtonText,
    );
  }

  // Abstract method for submit button key
  String getSubmitButtonKey();
}
