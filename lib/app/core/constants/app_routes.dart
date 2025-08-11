import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracka/app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tracka/app/shared/widgets/auth_widget.dart';
import 'package:tracka/app/features/auth/presentation/pages/auth_page.dart';
import 'package:tracka/app/features/dashboard/presentation/pages/dashboard.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tracka/app/features/settings/presentation/bloc/settings_event.dart';

class AppRoutes {
  AppRoutes();

  List<GoRoute> get routes => [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: BlocProvider(create: (_) => SettingsBloc()..add(const LoadSettingsEvent()), child: const AuthWidget()),
        );
      },
    ),
    GoRoute(
      path: '/auth',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: BlocProvider(create: (_) => AuthBloc(), child: AuthPage()));
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: BlocProvider(create: (_) => SettingsBloc()..add(const LoadSettingsEvent()), child: const Dashboard()),
        );
      },
    ),
  ];
}
