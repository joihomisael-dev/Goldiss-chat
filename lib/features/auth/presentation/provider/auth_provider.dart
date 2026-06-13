import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goldiss_chat/features/auth/data/auth_service.dart';
import 'package:goldiss_chat/features/auth/presentation/provider/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(client: Supabase.instance.client);
});

class AuthNotifier extends Notifier<AuthState> {
  late final AuthService _authService;

  @override
  AuthState build() {
    _authService = ref.read(authServiceProvider);
    //ecoute en temps réel
    _authService.authStateChanges.listen((user) {
      state = state.copyWith(user: user, errorMessage: null);
    });

    final curruntUser = _authService.currentUser;
    return AuthState(user: curruntUser);
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _authService.signIn(email, password);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _authService.signUp(email, password);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _authService.signOut();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false, clearUser: true);
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
