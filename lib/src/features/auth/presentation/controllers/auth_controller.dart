import 'package:keeley/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> sigInInUserWithEmailAndPassword(
      String email, String password) async {
    state = const AsyncLoading();
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(
          email: email, password: password);
      state = const AsyncData(null);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    state = const AsyncLoading();
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.createUserWithEmailAndPassword(
          email: email, password: password);
      state = const AsyncData(null);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();

    final authRepository = ref.watch(authRepositoryProvider);
    try {
      await authRepository.signOut();
      state = const AsyncData(null);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    state = const AsyncLoading();
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.updateDisplayName(displayName: displayName);
      state = const AsyncData(null);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteUser() async {
    state = const AsyncLoading();
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.deleteUser();
      state = const AsyncData(null);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
