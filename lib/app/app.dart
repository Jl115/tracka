import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_event.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_state.dart';
import 'package:tracka/app/service/go_router_service.dart';
import 'package:tracka/app/shared/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc()..add(const LoadSettingsEvent()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final themeModeName = state is SettingsLoaded ? state.settings.themeModeName : 'light';

          print('\x1B[32mApp - Theme Mode: $themeModeName\x1B[0m');
          if (state is SettingsLoaded) {
            print('\x1B[32mSettingsLoaded -------------------- ${state.settings.toString()}\x1B[0m');
          }
          return MaterialApp.router(
            routerConfig: GoRouterService().router,
            theme: AppTheme.lightMode,
            darkTheme: AppTheme.darkMode,
            themeMode: themeModeName == 'dark' ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
