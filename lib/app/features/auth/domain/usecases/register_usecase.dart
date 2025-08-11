import 'package:tracka/app/features/auth/data/repositories/auth_repository.dart';
import 'package:tracka/app/features/auth/domain/entities/auth_entity.dart';

class RegisterUsecase {
  final AuthRepository repository = AuthRepository();
  RegisterUsecase();

  Future<AuthEntity> call(String username, String password) => repository.register(username, password);
}
