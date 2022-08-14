import 'package:admin_dashboard/authentication/authentication.dart';
import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/page/issue_details_page.dart';
import 'package:admin_dashboard/page/login_page.dart';
import 'package:admin_dashboard/page/repo_details_page.dart';
import 'package:admin_dashboard/page/repo_page.dart';
import 'package:admin_dashboard/page/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../page/process_login_page.dart';
import '../service/fire_base.dart';

///The route generator that handles navigation throughout the app\

class RouteGenerator {
  RouteGenerator._();
  ///Welcome page path
  static const String welcomePage = '/';
  ///repository page path
  static const String repoPage = '/repos';
  static const String loginPage = '/login';
  static const String processPage = '/processPage';
  static const String repoDetailsPage = '/repoDetails';
  static const String waitingPage = '/waiting';
  static const String issueDetailPage = '/issueDetails';




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
      case repoDetailsPage:
        return MaterialPageRoute(
            builder: (_) => RepoDetailsPage(cache: cache,
              firebaseApp: firebaseApp,)
        );
      case loginPage:
        return MaterialPageRoute(
            builder: (_) => LoginPage(cache: cache,
                firebaseApp: firebaseApp,
            )
        );
      case processPage:
        return MaterialPageRoute(
            builder: (_) => ProcessLoginPage(cache: cache,
              firebaseApp: firebaseApp,
            )
        );
      case waitingPage:
        return MaterialPageRoute(
            builder: (_) => WaitingPage(cache: cache,
              firebaseApp: firebaseApp,
            )
        );
      case issueDetailPage:
        return MaterialPageRoute(
            builder: (_) => IssueDetailsPage(cache: cache,
              firebaseApp: firebaseApp,
            )
        );
      default:
        throw const FormatException('Route not found');
    }
  }
}
