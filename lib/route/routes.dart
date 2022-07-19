import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/page/repo_page.dart';
import 'package:admin_dashboard/page/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///The route generator that handles navigation throughout the app\

class RouteGenerator {
  RouteGenerator._();
  ///Welcome page path
  static const String welcomePage = '/';
  ///repository page path
  static const String repoPage = '/repos';



  ///decides which page to open depending on the path provided to the navigator
  static Route<dynamic> generateRoute(RouteSettings settings,
      AdminDashboardCache cache,
      //FireBaseService fire,
      FirebaseApp firebaseApp,
      ) {
    switch (settings.name) {
      case welcomePage:
        return MaterialPageRoute(
          builder: (_) =>  WelcomePage(cache: cache, //fire: fire,
            firebaseApp: firebaseApp,),
        );
      case repoPage:
        return MaterialPageRoute(
            builder: (_) => RepoPage(cache: cache, //fire: fire,
              firebaseApp: firebaseApp,),
        );
      default:
        throw const FormatException('Route not found');
    }
  }
}
