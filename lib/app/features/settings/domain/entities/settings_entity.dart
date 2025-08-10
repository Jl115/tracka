class SettingsEntity {
  final bool darkMode;
  final String themeModeName;
  final String username;
  final String password;
  final bool loggedIn;

  const SettingsEntity({
    required this.darkMode,
    required this.username,
    required this.password,
    required this.themeModeName,
    required this.loggedIn,
  });

  SettingsEntity copyWith({bool? darkMode, String? themeModeName, String? username, String? password, bool? loggedIn}) {
    return SettingsEntity(
      darkMode: darkMode ?? this.darkMode,
      themeModeName: themeModeName ?? this.themeModeName,
      username: username ?? this.username,
      password: password ?? this.password,
      loggedIn: loggedIn ?? this.loggedIn,
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
          password == other.password &&
          loggedIn == other.loggedIn;

  @override
  int get hashCode => darkMode.hashCode ^ themeModeName.hashCode ^ username.hashCode ^ password.hashCode;
}
