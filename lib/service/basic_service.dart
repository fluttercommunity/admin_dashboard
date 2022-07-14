import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/issue_model.dart';
import 'package:admin_dashboard/dto/pull_model.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:flutter/cupertino.dart';

///The interface used to define methods that the GitHub Service Implementor
///will provide
abstract class BasicServiceInterface {
  ///retrieve all issues across org
  List<Issue> getAllIssues();
  ///retrieve all issues in a specific repo
  Future<List<Issue>> getAllRepoIssues(
    String repoName,
    BuildContext context,
    AdminDashboardCache cache,
  );
  ///adds issue to a specific repo as defined in the issue param
  Future<Issue> addIssue(Issue issue);

  ///Retrieve all PRs across organization
  List<Pull> getAllPulls();

  ///retrieves all PRs in a specific repo
  Future<List<Pull>> getAllRepoPulls(
    String repoName,
    BuildContext context,
    AdminDashboardCache cache,
  );
  ///adds PR to a specific repo as defined in the PR param
  Future<Pull> addPull(Pull pr);

  ///retrieves all repositories belonging to a specific organization
  Future<List<SimpleRepo>> getAllRepos(  BuildContext context,
      AdminDashboardCache cache,
  );
}
