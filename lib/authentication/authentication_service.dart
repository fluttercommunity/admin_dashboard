import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:flutter/cupertino.dart';

///The interface used to define operations that will be provided by
///the Authentication Service Implementor
abstract class AuthenticationService {
  ///Login using an email and password
  Future<String?> emailLogin(String email, String password);
  ///Authenticate login using github's interface
  Future<String?> githubLogin(BuildContext context, AdminDashboardCache cache);
}
