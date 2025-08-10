import 'package:tracka/app/features/settings/domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  const SettingsModel({
    required super.darkMode,
    required super.username,
    required super.password,
    required super.themeModeName,
    required super.loggedIn,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      darkMode: json['dark_mode'] == 1,
      username: json['username'] ?? '',
      password: json['password_hash'] ?? '',
      themeModeName: json['dark_mode'] == 1 ? 'dark' : 'light',
      loggedIn: json['logged_in'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'darkMode': darkMode, 'username': username, 'password': password, 'themeModeName': themeModeName};
  }

  @override
  String toString() {
    return 'SettingsModel{darkMode: $darkMode, username: $username, password: $password, themeModeName: $themeModeName}, loggedIn: $loggedIn}';
  }

  @override
  copyWith({bool? darkMode, String? username, String? password, String? themeModeName, bool? loggedIn}) {
    return SettingsModel(
      darkMode: darkMode ?? this.darkMode,
      username: username ?? this.username,
      password: password ?? this.password,
      themeModeName: themeModeName ?? this.themeModeName,
      loggedIn: loggedIn ?? this.loggedIn,
    );
  }

  Map<String, dynamic> toDatabaseModel() {
    return {'dark_mode': darkMode ? 1 : 0};
  }
}
