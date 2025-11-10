import 'package:finanzio/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthStatus.unknown) {
    _checkInitialAuth();
  }

  Future<void> _checkInitialAuth() async {
    final isAuthenticated = await _repository.isAuthenticated();
    state = isAuthenticated
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  Future<void> login(String email, String password) async {
    try {
      await _repository.login(email, password);
      state = AuthStatus.authenticated;
    } catch (e) {
      state = AuthStatus.unauthenticated;
      rethrow;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthStatus.unauthenticated;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

final authStatusProvider = FutureProvider<AuthStatus>((ref) async {
  final isAuthenticated = await ref
      .read(authRepositoryProvider)
      .isAuthenticated();
  return isAuthenticated
      ? AuthStatus.authenticated
      : AuthStatus.unauthenticated;
});
