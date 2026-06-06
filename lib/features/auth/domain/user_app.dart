import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_app.freezed.dart';
part 'user_app.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    @Default("User") String displayName,
  }) = _AppUser;
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
