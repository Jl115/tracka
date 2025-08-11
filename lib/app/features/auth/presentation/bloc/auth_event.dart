sealed class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  const LoginEvent(this.username, this.password);
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  const RegisterEvent(this.username, this.password);
}

class ResetPasswordEvent extends AuthEvent {
  final String username;
  final String password;
  const ResetPasswordEvent(this.username, this.password);
}

class ChangeToLoginEvenet extends AuthEvent {
  const ChangeToLoginEvenet();
}

class ChangeToRegisterEvent extends AuthEvent {
  const ChangeToRegisterEvent();
}
