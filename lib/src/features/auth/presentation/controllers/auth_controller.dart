import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:keeley/src/common/widgets/loading_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  LoadingState<void> build() {
    return LoadingState.initial();
  }

  Future<void> sigInInUserWithEmailAndPassword(
      String email, String password) async {
    state = LoadingState.loading();
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(
          email: email, password: password);
      state = LoadingState.success(null);
    } on Exception catch (e) {
      state = LoadingState.error(e);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    state = LoadingState.loading();
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.createUserWithEmailAndPassword(
          email: email, password: password);
      state = LoadingState.success(null);
    } on Exception catch (e) {
      state = LoadingState.error(e);
    }
  }

  Future<void> signOut() async {
    state = LoadingState.loading();

    final authRepository = ref.watch(authRepositoryProvider);
    try {
      await authRepository.signOut();
      state = LoadingState.success(null);
    } on Exception catch (e) {
      state = LoadingState.error(e);
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    state = LoadingState.loading();
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.updateDisplayName(displayName: displayName);
      state = LoadingState.success(null);
    } on Exception catch (e) {
      state = LoadingState.error(e);
    }
  }

  Future<void> deleteUser() async {
    state = LoadingState.loading();
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.deleteUser();
      state = LoadingState.success(null);
    } on Exception catch (e) {
      state = LoadingState.error(e);
    }
  }
}
