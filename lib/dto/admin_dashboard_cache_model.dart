import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/main.dart';
///Our application's cache where user ID is stored
class AdminDashboardCache {
  ///user's github ID
  String? uid = '';
  ///Token used for authentication
  String token = EnvironmentConfig.token;
  late int index;
  ///List of repositories in the repo screen
  List<SimpleRepo> myTitleList = [];
  
  SimpleRepo simpleRepo =  SimpleRepo(name: '');
  bool isWeb = false;

  bool loggedIn = false;
}
