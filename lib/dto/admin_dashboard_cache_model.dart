import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/main.dart';
///Our application's cache where user ID is stored
class AdminDashboardCache {
  ///user's github ID
  String? uid = '';
  ///Token used for authentication
  String token = EnvironmentConfig.token;

  ///List of repositories in the repo screen
  List<SimpleRepo> myTitleList = [];
  /// Instance of simpleRepo object which is used to display a list of repos
  /// in an organization
  SimpleRepo simpleRepo =  SimpleRepo(name: '');
  /// boolean value to see if the platform is mobile or web browser
  bool isWeb = false;
  /// boolean value to see if the user is logged in or not
  bool loggedIn = false;
}
