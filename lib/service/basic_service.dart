import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../dto/adminDashboardCache_model.dart';
import '../dto/issue_model.dart';
import '../dto/pull_model.dart';


abstract class BasicServiceInterface{
   List<Issue> getAllIssues();
   Future<List<Issue>> getAllRepoIssues(String repoName, BuildContext context, AdminDashboardCache cache);
   Future<Issue> addIssue(Issue issue); //adds to a specific repo as defined in the issue param
   List<Pull> getAllPulls();
   Future<List<Pull>> getAllRepoPulls(String repoName, BuildContext context, AdminDashboardCache cache);
   Future<Pull> addPull(Pull pr); //adds to a specific repo as defined in the issue param
}