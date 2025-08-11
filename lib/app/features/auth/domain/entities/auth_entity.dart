import 'package:tracka/app/core/utils/hasher.dart';
import 'package:uuid/uuid.dart';

class AuthEntity {
  final String id;
  String username;
  String password;
  final Hasher hasher = Hasher.instance;

  AuthEntity({required this.username, required this.password}) : id = const Uuid().v4() {
    if (username.isEmpty || password.isEmpty) {
      throw ArgumentError('Username and password cannot be empty');
    }
    if (password.length < 6) {
      throw ArgumentError('Password must be at least 6 characters long');
    }
    password = hasher.hashPassword(password);
  }

  Map<String, dynamic> toJson() => {'id': id, 'username': username, 'password': password};

  Map<String, dynamic> toDatabaseJson() => {
    'id': id,
    'username': username,
    'logged_in': 1, // login new created user
    'password_hash': password,
    'created_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
  };
}
