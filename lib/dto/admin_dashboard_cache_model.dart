import 'package:admin_dashboard/main.dart';
///Our application's cache where user ID is stored
class AdminDashboardCache {
  ///User ID
  String? uid = '';
  ///User token
  String token = EnvironmentConfig.token;
}
