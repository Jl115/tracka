import 'package:tracka/app/features/auth/data/datasources/auth_datasource.dart';
import 'package:tracka/app/features/auth/domain/entities/auth_entity.dart';

class AuthRepository {
  final AuthDataSource local = AuthDataSource();

  AuthRepository();

  Future<AuthEntity> login(String username, String password) async {
    return local.login(AuthEntity(username: username, password: password));
  }

  Future<void> logout() async {}
  Future<AuthEntity> register(String username, String password) async {
    return local.register(AuthEntity(username: username, password: password));
  }

  Future<AuthEntity> resetPassword(String username, String newPassword) async {
    return AuthEntity(username: username, password: newPassword);
  }
}
