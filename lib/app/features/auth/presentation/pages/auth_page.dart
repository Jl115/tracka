import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracka/app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tracka/app/features/auth/presentation/bloc/auth_event.dart';
import 'package:tracka/app/features/auth/presentation/bloc/auth_state.dart';
import 'package:tracka/app/service/go_router_service.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthSuccess) {
            GoRouterService().go('/home');
          }
        },
        builder: (context, state) {
          final bool isLogin = state is AuthInitial || state is LoginInitial;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child:
                      isLogin
                          ? _buildForm(
                            context,
                            title: "Welcome Back",
                            subtitle: "Sign in to continue",
                            primaryText: "Login",
                            secondaryText: "Create Account",
                            onPrimary:
                                () => context.read<AuthBloc>().add(
                                  LoginEvent(_usernameCtrl.text.trim(), _passwordCtrl.text.trim()),
                                ),
                            onSecondary: () => context.read<AuthBloc>().add(ChangeToRegisterEvent()),
                            fields: [
                              _input(context, "Username", controller: _usernameCtrl),
                              const SizedBox(height: 16),
                              _input(context, "Password", obscure: true, controller: _passwordCtrl),
                            ],
                          )
                          : _buildForm(
                            context,
                            title: "Join Tracka",
                            subtitle: "Create your free account",
                            primaryText: "Register",
                            secondaryText: "Already have an account?",
                            onPrimary:
                                () => context.read<AuthBloc>().add(
                                  RegisterEvent(_usernameCtrl.text.trim(), _passwordCtrl.text.trim()),
                                ),
                            onSecondary: () => context.read<AuthBloc>().add(ChangeToLoginEvenet()),
                            fields: [
                              _input(context, "Username", controller: _usernameCtrl),
                              const SizedBox(height: 16),
                              _input(context, "Password", obscure: true, controller: _passwordCtrl),
                              const SizedBox(height: 16),
                              _input(context, "Confirm Password", obscure: true, controller: _confirmCtrl),
                            ],
                          ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String primaryText,
    required String secondaryText,
    required VoidCallback onPrimary,
    required VoidCallback onSecondary,
    required List<Widget> fields,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      key: ValueKey(title),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tracka", style: theme.textTheme.displayLarge?.copyWith(color: cs.primary)),
        const SizedBox(height: 8),
        Text(title, style: theme.textTheme.headlineLarge?.copyWith(color: cs.onBackground)),
        const SizedBox(height: 4),
        Text(subtitle, style: theme.textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 32),
        ...fields,
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: onPrimary, child: Text(primaryText.toUpperCase())),
        ),
        const SizedBox(height: 12),
        Center(child: TextButton(onPressed: onSecondary, child: Text(secondaryText))),
      ],
    );
  }

  static Widget _input(BuildContext context, String label, {bool obscure = false, TextEditingController? controller}) {
    return TextField(controller: controller, obscureText: obscure, decoration: InputDecoration(labelText: label));
  }
}
