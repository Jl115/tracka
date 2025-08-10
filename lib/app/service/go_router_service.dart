import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracka/app/core/constants/app_routes.dart';

class GoRouterService {
  static final GoRouterService _instance = GoRouterService._internal();
  factory GoRouterService() => _instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GoRouter? _router;

  GoRouterService._internal() {
    // Private constructor to enforce singleton pattern
    _router = GoRouter(
      initialLocation: '/',
      routes: AppRoutes().routes,
      errorBuilder: (context, state) => Scaffold(body: Center(child: Text('404: ${state.error}'))),
      navigatorKey: navigatorKey,
    );
  }

  GoRouter get router {
    if (_router == null) {
      throw Exception('Router not initialized. Call initRouter() first.');
    }
    return _router!;
  }

  void go(String path) => _router!.go(path);
  void push(String path) => _router!.push(path);
}
