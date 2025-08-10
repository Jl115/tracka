import 'package:tracka/app/features/settings/data/datasources/settings_datasource.dart';
import 'package:tracka/app/features/settings/data/models/settings_model.dart';
import 'package:tracka/app/features/settings/domain/entities/settings_entity.dart';

class SettingsRepository {
  final SettingsDataSource local = SettingsDataSource();

  SettingsRepository();

  Future<SettingsEntity> loadSettings() => local.load();

  Future<bool> isLoggedIn() async {
    final settings = await local.load();
    return settings.username.isNotEmpty && settings.password.isNotEmpty;
  }

  Future<void> saveSettings(SettingsEntity settings) => local.save(
    SettingsModel(
      darkMode: settings.darkMode,
      username: settings.username,
      password: settings.password,
      themeModeName: settings.themeModeName,
    ),
  );
}
