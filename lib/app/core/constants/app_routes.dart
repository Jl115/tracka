import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracka/app/core/database/controller/database_controller.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_event.dart';
import 'package:tracka/app/shared/widgets/auth_wrapper.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tracka/app/features/settings/domain/usecases/load_settings_usecase.dart';

class AppRoutes {
  AppRoutes();

  List<GoRoute> get routes => [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: BlocProvider(
            create: (_) => SettingsBloc()..add(const LoadSettingsEvent()),
            child: const AuthWrapper(),
          ),
        );
      },
    ),
  ];
}
