import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });

  final String id;
  final String email;
  final String displayName;
  final String photoUrl;

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
      ];
}
