import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common_widgets/loading_button.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/presentation/auth_controller.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/alert_dialogs.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Sign-in screen with email and password authentication
class CustomSignInScreen extends ConsumerStatefulWidget {
  const CustomSignInScreen({super.key});

  @override
  ConsumerState<CustomSignInScreen> createState() => _CustomSignInScreenState();
}

class _CustomSignInScreenState extends ConsumerState<CustomSignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<ShadFormState> _formKey;

  // Layout constants
  static const double _logoSize = 120.0;
  static const double _maxFormWidth = 400.0;
  static const double _horizontalPadding = 24.0;
  static const double _verticalOffset = -20.0;
  static const double _logoTopMargin = 180.0;
  static const double _logoBottomMargin = 48.0;
  static const String _logoAssetPath = 'assets/logo_min.svg';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<ShadFormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.saveAndValidate()) {
      return;
    }

    final authController = ref.read(authControllerProvider.notifier);
    await authController.sigInInUserWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  String? _validateEmail(String value) {
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

  String? _validatePassword(String value) {
    if (value.trim().isEmpty) {
      return Strings.requiredField;
    }
    return null;
  }

  void _handleAuthError(Object error) {
    showExceptionToast(
      context: context,
      title: Strings.signInFailed,
      exception: error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildScrollableForm(),
      ),
    );
  }

  Widget _buildScrollableForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: SizedBox(
        height: _calculateAvailableHeight(),
        child: Center(
          child: Transform.translate(
            offset: const Offset(0, _verticalOffset),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  /// Calculates available screen height minus system padding
  double _calculateAvailableHeight() {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
  }

  Widget _buildForm() {
    return ShadForm(
      key: _formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxFormWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLogo(),
            gapH32,
            _buildEmailField(),
            gapH16,
            _buildPasswordField(),
            gapH24,
            _buildSignInButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        width: _logoSize,
        height: _logoSize,
        margin: const EdgeInsets.only(
          top: _logoTopMargin,
          bottom: _logoBottomMargin,
        ),
        child: SvgPicture.asset(
          _logoAssetPath,
          width: _logoSize,
          height: _logoSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    final authState = ref.watch(authControllerProvider);

    return ShadInputFormField(
      key: const Key(Keys.emailField),
      controller: _emailController,
      id: Keys.email,
      label: const Text(Strings.email),
      placeholder: const Text(Strings.emailPlaceholder),
      keyboardType: TextInputType.emailAddress,
      enabled: !authState.isLoading,
      validator: _validateEmail,
    );
  }

  Widget _buildPasswordField() {
    final authState = ref.watch(authControllerProvider);

    return ShadInputFormField(
      key: const Key(Keys.passwordField),
      controller: _passwordController,
      id: Keys.password,
      label: const Text(Strings.password),
      placeholder: const Text(Strings.passwordPlaceholder),
      obscureText: true,
      enabled: !authState.isLoading,
      validator: _validatePassword,
    );
  }

  Widget _buildSignInButton() {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authControllerProvider);

        // Listen for auth state changes
        ref.listen(authControllerProvider, (previous, next) {
          if (next.hasError) {
            _handleAuthError(next.error!);
          }
        });

        return LoadingButton(
          key: const Key(Keys.signInButton),
          onPressed: _handleSignIn,
          isLoading: authState.isLoading,
          loadingText: Strings.signInLoading,
          child: const Text(Strings.signIn),
        );
      },
    );
  }
}
