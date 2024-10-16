import 'package:brian_test/ui/controllers/auth_controller.dart';
import 'package:brian_test/ui/main/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrianTestRoutes {
  factory BrianTestRoutes._() => _singleton;

  BrianTestRoutes._internal() {
    routes = GoRouter(
      routes: [
        for (final page in BrianTestPage.pages)
          GoRoute(
            name: page.name,
            path: page.route,
            redirect: (_, __) {
              return page.isProtectedByLogin ? _protectedByLogin() : null;
            },
            builder: (_, state) => page.builder(
              state.pathParameters,
              state.uri.queryParameters,
            ),
          ),
      ],
    );
  }

  static final BrianTestRoutes _singleton = BrianTestRoutes._internal();

  // ignore: prefer_constructors_over_static_methods
  static BrianTestRoutes get instance => BrianTestRoutes._();

  final _authController = AuthController.instance;
  late GoRouter routes;

  String? _protectedByLogin() {
    final isLogged = _authController.isLogged;

    if (!isLogged) {
      return BrianTestPage.login.route;
    }

    return null;
  }
}

extension RouteExtension on BuildContext {
  void navigateTo(BrianTestPage page) {
    GoRouter.of(this).pushNamed(page.name);
  }

  void replace(BrianTestPage page) {
    // ignore: inference_failure_on_function_invocation
    GoRouter.of(this).replaceNamed(page.name);
  }
}
