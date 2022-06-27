import 'package:admin_dashboard/main.dart';
import 'package:admin_dashboard/page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//The route generator that handles navigation throughout the app\

class RouteGenerator {
  static const String loginPage = '/';
  RouteGenerator._();

  //generateRoute method decides which page to open depending on the path provided to the navigator

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
         return MaterialPageRoute(builder: (_) =>  const LoginPage(),);
      default:
        throw FormatException("Route not found");
    }
  }
}
