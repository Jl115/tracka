sealed class SettingsEvent {
  const SettingsEvent();
}

class LoadSettingsEvent extends SettingsEvent {
  const LoadSettingsEvent();
}

class ToggleDarkModeEvent extends SettingsEvent {
  const ToggleDarkModeEvent();
}

class UpdateUsernameEvent extends SettingsEvent {
  final String username;
  const UpdateUsernameEvent(this.username);
}

class UpdateThemeModeEvent extends SettingsEvent {
  final String themeModeName; // "light" or "dark"
  const UpdateThemeModeEvent(this.themeModeName);
}

