import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_app.freezed.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({required String id, required String email}) = _AppUser;

  factory AppUser.fromSupabase(User user) {
    return AppUser(id: user.id, email: user.email ?? "");
  }
}
