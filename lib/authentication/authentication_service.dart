
import 'package:flutter/cupertino.dart';

import '../dto/adminDashboardCache_model.dart';
import '../dto/issue_model.dart';

abstract class AuthenticationService{
  Future<String?> emailLogin(String email, String password);
  Future<String?> githubLogin(BuildContext context, AdminDashboardCache cache);
}