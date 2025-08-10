import 'package:tracka/app/features/settings/domain/entities/settings_entity.dart';

sealed class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsLoaded extends SettingsState {
  final SettingsEntity settings;
  const SettingsLoaded(this.settings);
}

class SettingsFailure extends SettingsState {
  final String message;
  const SettingsFailure(this.message);
}
