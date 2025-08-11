import 'package:tracka/app/core/database/controller/database_controller.dart';
import 'package:tracka/app/features/auth/data/models/auth_model.dart';
import 'package:tracka/app/features/auth/domain/entities/auth_entity.dart';

class AuthDataSource {
  final _key = 'user';
  final _databaseController = DatabaseController();

  Future<AuthModel> login(AuthEntity entity) async {
    final jsonMap = await _databaseController.findOne(
      table: _key,
      where: 'username = ? AND password_hash = ?',
      whereArgs: [entity.username, entity.password],
    );

    if (jsonMap == null) {
      throw Exception('Invalid username or password');
    }

    return AuthModel.fromJson(jsonMap);
  }

  Future<void> logout() async {
    // Implement logout logic if necessary, e.g., clearing session data
  }

  Future<AuthModel> register(AuthEntity entity) async {
    final existingUser = await _databaseController.findOne(
      table: _key,
      where: 'username = ?',
      whereArgs: [entity.username],
    );
    if (existingUser != null) throw Exception('Username already exists');

    final dbData = entity.toDatabaseJson();
    await _databaseController.create(table: _key, value: dbData);
    return AuthModel.fromJson(entity.toJson());
  }

  Future<void> resetPassword(String username, String newPassword) async {
    final user = await _databaseController.findOne(table: _key, where: 'username = ?', whereArgs: [username]);
    if (user == null) {
      throw Exception('User not found');
    }
    user['password'] = newPassword;
    await _databaseController.update(table: _key, data: user, where: 'username = ?', whereArgs: [username]);
  }
}
