import 'package:tracka/app/features/auth/data/repositories/auth_repository.dart';
import 'package:tracka/app/features/auth/domain/entities/auth_entity.dart';

class LoginUsecase {
  final AuthRepository repository = AuthRepository();

  LoginUsecase();

  Future<AuthEntity> call(String username, String password) => repository.login(username, password);
}
