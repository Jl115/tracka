import 'package:tracka/app/features/settings/data/repositories/settings_repository.dart';
import 'package:tracka/app/features/settings/domain/entities/settings_entity.dart';

class LoadSettingsUseCase {
  final SettingsRepository repository = SettingsRepository();
  LoadSettingsUseCase();

  Future<SettingsEntity> call() => repository.loadSettings();
}
