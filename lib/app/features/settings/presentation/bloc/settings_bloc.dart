import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracka/app/core/database/controller/database_controller.dart';
import 'package:tracka/app/features/settings/domain/usecases/load_settings_usecase.dart';
import 'package:tracka/app/features/settings/domain/usecases/save_settings_usecase.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_event.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static final SettingsBloc _instance = SettingsBloc._internal();

  factory SettingsBloc() => _instance;

  //* USECASES
  final LoadSettingsUseCase loadSettingsUseCase = LoadSettingsUseCase();
  final SaveSettingsUseCase saveSettingsUseCase = SaveSettingsUseCase();

  //* CONTROLLERS
  final DatabaseController databaseController = DatabaseController();

  //* SERVICES

  //* PRIVATE CONSTRUCTOR
  SettingsBloc._internal() : super(const SettingsInitial()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ToggleDarkModeEvent>(_onToggleDarkMode);
    on<UpdateUsernameEvent>(_onUpdateUsername);
    on<UpdateThemeModeEvent>(_onUpdateThemeMode);
  }

  Future<void> _onLoadSettings(LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(const SettingsLoading());
    try {
      final settings = await loadSettingsUseCase();
      emit(SettingsLoaded(settings));
    } catch (e) {
      emit(SettingsFailure(e.toString()));
    }
  }

  Future<void> _onToggleDarkMode(ToggleDarkModeEvent event, Emitter<SettingsState> emit) async {
    if (state is! SettingsLoaded) return;
    final current = (state as SettingsLoaded).settings;
    final isDark = !current.darkMode;
    final updated = current.copyWith(darkMode: isDark, themeModeName: isDark ? 'dark' : 'light');
    await saveSettingsUseCase(updated);
    emit(SettingsLoaded(updated));
  }

  Future<void> _onUpdateUsername(UpdateUsernameEvent event, Emitter<SettingsState> emit) async {
    if (state is! SettingsLoaded) return;
    final current = (state as SettingsLoaded).settings;
    final updated = current.copyWith(username: event.username);
    await saveSettingsUseCase(updated);
    emit(SettingsLoaded(updated));
  }

  Future<void> _onUpdateThemeMode(UpdateThemeModeEvent event, Emitter<SettingsState> emit) async {
    if (state is! SettingsLoaded) return;
    final current = (state as SettingsLoaded).settings;
    final isDark = event.themeModeName == 'dark';
    final updated = current.copyWith(themeModeName: event.themeModeName, darkMode: isDark);
    await saveSettingsUseCase(updated);
    emit(SettingsLoaded(updated));
  }
}
