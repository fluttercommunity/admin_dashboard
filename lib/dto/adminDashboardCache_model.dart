import '../injection.dart';
import '../main.dart';

class AdminDashboardCache{ //Our application's cache where user ID is stored
  //final EnvironmentConfig env = getIt<EnvironmentConfig>();
  String? uid = "";
  String token = EnvironmentConfig.token;
}