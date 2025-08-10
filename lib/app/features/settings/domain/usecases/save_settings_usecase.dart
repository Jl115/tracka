import 'package:tracka/app/features/settings/data/repositories/settings_repository.dart';
import 'package:tracka/app/features/settings/domain/entities/settings_entity.dart';

class SaveSettingsUseCase {
  final SettingsRepository repository = SettingsRepository();
  SaveSettingsUseCase();

  Future<void> call(SettingsEntity settings) => repository.saveSettings(settings);
}
