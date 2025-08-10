import 'package:tracka/app/features/settings/data/repositories/settings_repository.dart';

class LoggedInUsecase {
  final SettingsRepository repository = SettingsRepository();
  LoggedInUsecase();

  Future<bool> call() => repository.isLoggedIn();
}
