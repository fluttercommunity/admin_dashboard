import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/main.dart';
///Our application's cache where user ID is stored
class AdminDashboardCache {
  String? uid = '';
  String token = EnvironmentConfig.token;

  ///List of repositories in the repo screen
  List<SimpleRepo> myTitleList = [];
}
