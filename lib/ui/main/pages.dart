import 'package:brian_test/ui/pages/home_page.dart';
import 'package:brian_test/ui/pages/login_page.dart';
import 'package:flutter/material.dart';

class BrianTestPage extends BrianTestRouteInterface {
  BrianTestPage._({
    required String name,
    required String route,
    required bool isProtectedByLogin,
    required RouteBuilder page,
  }) : super._(
          page,
          name: name,
          route: route,
          isProtectedByLogin: isProtectedByLogin,
        );

  static final home = BrianTestPage._(
    name: 'Home',
    route: '/',
    isProtectedByLogin: true,
    page: (_) => HomePage(),
  );

  static final login = BrianTestPage._(
    name: 'Login',
    route: '/login',
    isProtectedByLogin: false,
    page: (_) => LoginPage(),
  );

  static final pages = [
    login,
    home,
  ];

  @override
  String toString() {
    return 'BrianTestRoute.$name';
  }
}

abstract class BrianTestRouteInterface {
  BrianTestRouteInterface._(
    this._pageBuilder, {
    required this.name,
    required this.route,
    required this.isProtectedByLogin,
  });

  final String name;
  final String route;
  final bool isProtectedByLogin;
  final RouteBuilder _pageBuilder;

  Widget builder(
    Map<String, String> pathParams,
    Map<String, String> queryParams,
  ) {
    return _pageBuilder(RouteOption(pathParams, queryParams));
  }
}

typedef RouteBuilder = Widget Function(RouteOption options);

class RouteOption {
  RouteOption(this.pathParams, this.queryParams);

  final Map<String, String> pathParams;
  final Map<String, String> queryParams;
}
