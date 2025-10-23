import 'package:finanzio/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum untuk status otentikasi
enum AuthStatus { unknown, authenticated, unauthenticated }

// State Notifier
class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthStatus.unknown) {
    _checkInitialAuth();
  }

  // Cek token saat aplikasi dimuat
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

// State Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

// Future Provider untuk cek status awal
final authStatusProvider = FutureProvider<AuthStatus>((ref) async {
  final isAuthenticated = await ref
      .read(authRepositoryProvider)
      .isAuthenticated();
  return isAuthenticated
      ? AuthStatus.authenticated
      : AuthStatus.unauthenticated;
});
