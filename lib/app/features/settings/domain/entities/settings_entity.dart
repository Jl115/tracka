class SettingsEntity {
  final bool darkMode;
  final String themeModeName;
  final String username;
  final String password;

  const SettingsEntity({
    required this.darkMode,
    required this.username,
    required this.password,
    required this.themeModeName,
  });

  SettingsEntity copyWith({bool? darkMode, String? themeModeName, String? username, String? password}) {
    return SettingsEntity(
      darkMode: darkMode ?? this.darkMode,
      themeModeName: themeModeName ?? this.themeModeName,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsEntity &&
          runtimeType == other.runtimeType &&
          darkMode == other.darkMode &&
          themeModeName == other.themeModeName &&
          username == other.username &&
          password == other.password;

  @override
  int get hashCode => darkMode.hashCode ^ themeModeName.hashCode ^ username.hashCode ^ password.hashCode;
}
