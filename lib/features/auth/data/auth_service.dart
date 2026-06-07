import 'package:goldiss_chat/features/auth/domain/user_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client;
  AuthService({required this.client});

  Future<AppUser> signUp(String email, String password) async {
    var response = await client.auth.signUp(email: email, password: password);
    return AppUser.fromSupabase(response.user!);
  }

  Future<AppUser> signIn(String email, String password) async {
    var response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return AppUser.fromSupabase(response.user!);
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  Stream<AppUser?> get authStateChanges {
    return client.auth.onAuthStateChange.map((event) {
      var user = event.session?.user;
      if (user != null) {
        return AppUser(id: user.id, email: user.email ?? "");
      } else {
        return null;
      }
    });
  }

  AppUser? get currentUser {
    var user = client.auth.currentUser;
    if (user == null) return null;
    return AppUser(id: user.id, email: user.email ?? "");
  }
}
