class AuthValidator {
  factory AuthValidator() => _instance;
  AuthValidator._internal();
  static final AuthValidator _instance = AuthValidator._internal();

  String validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      throw FormatException('Email cannot be empty');
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      throw FormatException('Invalid email format');
    }
    return value;
  }

  String validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      throw FormatException('Username cannot be empty');
    }
    if (value.length < 3) {
      throw FormatException('Username must be at least 3 characters long');
    }
    return value;
  }

  String validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      throw FormatException('Password cannot be empty');
    }
    if (value.length < 6) {
      throw FormatException('Password must be at least 6 characters long');
    }
    return value;
  }
}

