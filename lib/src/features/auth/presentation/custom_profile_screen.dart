import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/app_bar.dart';
import 'package:keeley/src/common/widgets/loading_button.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/features/auth/presentation/auth_controller.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:keeley/src/utils/dialogs.dart';
import 'package:keeley/src/utils/toasts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CustomProfileScreen extends ConsumerStatefulWidget {
  const CustomProfileScreen({super.key});

  @override
  ConsumerState<CustomProfileScreen> createState() =>
      _CustomProfileScreenState();
}

class _CustomProfileScreenState extends ConsumerState<CustomProfileScreen> {
  late final TextEditingController _displayNameController;
  late final GlobalKey<ShadFormState> _formKey;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _formKey = GlobalKey<ShadFormState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize display name from current user
    final user = ref.read(authRepositoryProvider).currentUser;
    if (_displayNameController.text.isEmpty) {
      _displayNameController.text = user?.displayName ?? '';
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdateDisplayName() async {
    if (!_formKey.currentState!.saveAndValidate()) {
      return;
    }

    final newDisplayName = _displayNameController.text.trim();
    final authController = ref.read(authControllerProvider.notifier);

    try {
      await authController.updateDisplayName(newDisplayName);

      _handleUpdateSuccess();
    } catch (e) {
      _handleAuthError(e);
    }
  }

  Future<void> _handleSignOut() async {
    final confirmed = await showAlertDialog(
      context: context,
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
      isDestructive: true,
    );

    if (confirmed == true) {
      final authController = ref.read(authControllerProvider.notifier);
      await authController.signOut();
    }
  }

  Future<void> _handleDeleteAccount() async {
    final confirmed = await showAlertDialog(
      context: context,
      title: Strings.deleteAccountConfirmation,
      content: Strings.deleteAccountMessage,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.deleteAccount,
      isDestructive: true,
    );

    if (confirmed == true) {
      final authController = ref.read(authControllerProvider.notifier);
      await authController.deleteUser();
    }
  }

  void _handleAuthError(Object error) {
    showExceptionToast(
      context: context,
      title: Strings.updateDisplayNameFailed,
      exception: error,
    );
  }

  void _handleUpdateSuccess() {
    showSuccessToast(
      context: context,
      description: Strings.updateDisplayNameSuccess,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    ref.listen(authStateChangesProvider, (previous, next) {
      final previousUser = previous?.value;
      final currentUser = next.value;

      if (previousUser?.displayName != currentUser?.displayName &&
          currentUser?.displayName != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _displayNameController.text = currentUser!.displayName!;
          }
        });
      }
    });

    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        _handleAuthError(next.error!);
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ScrollableAppBar(
        title: Strings.profile,
        scrollController: _scrollController,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.only(
          top: kToolbarHeight +
              Sizes.p16, // Platz für App Bar + zusätzlicher Abstand
          left: Sizes.p24,
          right: Sizes.p24,
          bottom: Sizes.p24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileSettingsCard(theme),
            gapH24,
            _buildActionsCard(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSettingsCard(ShadThemeData theme) {
    final authState = ref.watch(authControllerProvider);

    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p2),
        child: ShadForm(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Strings.profileSettings,
                style: theme.textTheme.h4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              gapH16,
              ShadInputFormField(
                key: Key(Keys.displayNameField),
                controller: _displayNameController,
                id: 'displayName',
                label: Text(Strings.displayName),
                placeholder: Text(Strings.displayNamePlaceholder),
                enabled: !authState.isLoading,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return Strings.requiredField;
                  }
                  return null;
                },
              ),
              gapH16,
              LoadingButton(
                key: Key(Keys.updateDisplayNameButton),
                onPressed: _handleUpdateDisplayName,
                isLoading: authState.isLoading,
                variant: LoadingButtonVariant.primary,
                child: Text(Strings.updateDisplayName),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionsCard(ShadThemeData theme) {
    final authState = ref.watch(authControllerProvider);

    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Strings.actions,
              style: theme.textTheme.h4.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            gapH16,
            ShadButton.outline(
              key: Key(Keys.signOutButton),
              onPressed: authState.isLoading ? null : _handleSignOut,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    size: 18,
                    color: theme.colorScheme.foreground,
                  ),
                  gapW8,
                  Text(Strings.logout),
                ],
              ),
            ),
            gapH16,
            LoadingButton(
              key: Key(Keys.deleteAccountButton),
              onPressed: _handleDeleteAccount,
              isLoading: authState.isLoading,
              variant: LoadingButtonVariant.destructive,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_forever,
                    size: 18,
                    color: theme.colorScheme.destructiveForeground,
                  ),
                  gapW8,
                  Text(Strings.deleteAccount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
