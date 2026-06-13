import 'package:goldiss_chat/features/auth/domain/user_app.dart';

class AuthState {
  final AppUser? user;
  final bool isLoading;
  final String? errorMessage;
  final bool clearUser;

  AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
    this.clearUser = false,
  });

  AuthState copyWith({
    AppUser? user,
    bool? isLoading,
    String? errorMessage,
    bool clearUser = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
