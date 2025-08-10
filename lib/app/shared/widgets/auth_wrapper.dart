import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_event.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_state.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            // e.g., show SnackBar on settings change
          },
          builder: (context, state) {
            if (state is SettingsLoading) return const CircularProgressIndicator();
            if (state is SettingsLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dark mode: ${state.settings.darkMode}'),
                  ElevatedButton(
                    onPressed: () => context.read<SettingsBloc>().add(const ToggleDarkModeEvent()),
                    child: const Text('Toggle Dark Mode'),
                  ),
                ],
              );
            }
            return const Text('No settings found');
          },
        ),
      ),
    );
  }
}
