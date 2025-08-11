import 'package:tracka/app/features/auth/data/repositories/auth_repository.dart';
import 'package:tracka/app/features/auth/domain/entities/auth_entity.dart';

class ResetPasswordUsecase {
  final AuthRepository repository = AuthRepository();

  ResetPasswordUsecase();

  Future<AuthEntity> call(String username, String password) => repository.resetPassword(username, password);
}
