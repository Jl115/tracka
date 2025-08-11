import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_state.dart';
import 'package:tracka/app/service/go_router_service.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is IsLoggedInState && state.isLoggedIn) {
          GoRouterService().go('/home');
        } else if (state is IsLoggedInState && !state.isLoggedIn) {
          GoRouterService().go('/auth');
        }
      },
      builder: (context, state) {
        return const SizedBox();
      },
    );
  }
}
