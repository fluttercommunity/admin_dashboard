import 'package:admin_dashboard/page/login_page.dart';
import 'package:flutter/material.dart';

///The route generator that handles navigation throughout the app\

class RouteGenerator {
  RouteGenerator._();
  ///login page path
  static const String loginPage = '/';

  ///decides which page to open depending on the path provided to the navigator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      default:
        throw const FormatException('Route not found');
    }
  }
}
