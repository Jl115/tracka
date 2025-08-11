import 'package:tracka/app/features/auth/domain/entities/auth_entity.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class RegisterUser extends AuthState {
  final String username;
  final String password;
  const RegisterUser(this.username, this.password);
}

class LoginUser extends AuthState {
  final String username;
  final String password;
  const LoginUser(this.username, this.password);
}

class LogoutUser extends AuthState {
  const LogoutUser();
}

class ResetPassword extends AuthState {
  final String username;
  const ResetPassword(this.username);
}

class Authenticated extends AuthState {
  final String username;
  const Authenticated(this.username);
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}

class AuthSuccess extends AuthState {
  final AuthEntity message;
  const AuthSuccess(this.message);
}

class LoginInitial extends AuthState {
  const LoginInitial();
}

class RegisterInitial extends AuthState {
  const RegisterInitial();
}
