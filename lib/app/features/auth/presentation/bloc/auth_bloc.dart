import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracka/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tracka/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:tracka/app/features/auth/presentation/bloc/auth_validator.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_event.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_state.dart';
import 'package:tracka/app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:tracka/app/features/auth/presentation/bloc/auth_event.dart';
import 'package:tracka/app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static final AuthBloc _instance = AuthBloc._internal();

  factory AuthBloc() => _instance;

  //* USECASES
  final LoginUsecase loginUsecase = LoginUsecase();
  final RegisterUsecase registerUsecase = RegisterUsecase();
  final ResetPasswordUsecase resetPasswordUsecase = ResetPasswordUsecase();

  //* CONTROLLERS

  //* SERVICES

  //* VALIDATORS
  final AuthValidator authValidator = AuthValidator();

  //* PRIVATE CONSTRUCTOR
  AuthBloc._internal() : super(const AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ResetPasswordEvent>(_onResetPassword);
    on<ChangeToLoginEvenet>(_onChangeToLogin);
    on<ChangeToRegisterEvent>(_onChangeToRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      var validatedUsername = authValidator.validateUsername(event.username);
      var validatedPassword = authValidator.validatePassword(event.password);
      var authEntity = await loginUsecase(validatedUsername, validatedPassword);
      emit(AuthSuccess(authEntity));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll(RegExp(r'^\w+Exception: '), '')));
      emit(AuthInitial()); // Reset to initial state on failure
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      var authEntity = await registerUsecase(event.username, event.password);
      emit(AuthSuccess(authEntity));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      var authEntity = await resetPasswordUsecase(event.username, event.password);
      emit(AuthSuccess(authEntity));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onChangeToLogin(ChangeToLoginEvenet event, Emitter<AuthState> emit) async {
    emit(const LoginInitial());
  }

  Future<void> _onChangeToRegister(ChangeToRegisterEvent event, Emitter<AuthState> emit) async {
    emit(const RegisterInitial());
  }
}
