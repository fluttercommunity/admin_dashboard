import 'dart:convert';
import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/issue_model.dart';
import 'package:admin_dashboard/dto/pull_model.dart';
import 'package:admin_dashboard/service/basic_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


///implements the methods that Firebase as a middleware
///will provide for GitHub
class FireBaseService implements BasicServiceInterface {
  @override
  Future<Issue> addIssue(Issue issue) async {
    const siteUrl =
        '${Constants.repoLogLink}'
              '/${Constants.repoNameTest}'
               '/${Constants.issues}.json';
    try {
      final urlChat = Uri.parse(siteUrl);
      final issue = Issue(
          issueID: 250,
          state: 'closed',
          title: 'Test Issue 25',
          loggedAt: DateTime.now(),
          closedAt: DateTime.now(),
          closedBy: 'Amer',
          commentsNumber: 4,
          repository: Constants.repoNameTest,
      );
      debugPrint(issue.toJson().toString());
      final response1 = await http.post(urlChat,
          body: json.encode(issue.toJson()),);
      debugPrint(response1.statusCode.toString());
      return issue;
    } catch (error) {
      rethrow;
    }
  }

  @override
  List<Issue> getAllIssues() {
    // TODO: implement getAllIssues
    throw UnimplementedError();
  }

  @override
  Future<List<Issue>> getAllRepoIssues(
    String repoName,
    BuildContext context,
    AdminDashboardCache cache,
  ) async {
    final List<Issue> result = [];
    final url = Uri.parse('https://api.github.com$repoName');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${cache.token}',
        },
      );
      if (response.statusCode != 200) {
        return result;
      }

      final body = response.body;
      if (body == 'null') {
        return result;
      }

      final issues = json.decode(response.body);
      List<dynamic> issueList;
      issueList = issues as List;
      for (final element in issueList) {
        Map<String, Object?> issue;
        issue = element as Map<String, Object?>;
        debugPrint("id=${issue['id'] ?? "null"}");
        debugPrint("title=${issue['title'] ?? "null"}");
      }

      return result;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Pull> addPull(Pull pr) async {
    const siteUrl =
        'https://admin-dashboard-b9503-default-rtdb.firebaseio.com/activity_log'
            '/${Constants.repoNameTest}'
            '/${Constants.pulls}.json';
    try {
      final urlChat = Uri.parse(siteUrl);
      Pull pull;
      pull = Pull(
        userId: 250,
        state: 'closed',
        title: 'Test PR',
        loggedAt: DateTime.now(),
        closedAt: DateTime.now(),
        closedBy: 'Amer',
        commentsNumber: 4,
        repository: 'Flutter Test',
      );
      debugPrint(pull.toJson().toString());
      final response2 =
          await http.post(urlChat, body: json.encode(pull.toJson()));
      debugPrint(response2.statusCode.toString());
      return pull;
    } catch (error) {
      rethrow;
    }
  }

  @override
  List<Pull> getAllPulls() {
    // TODO: implement getAllPulls
    throw UnimplementedError();
  }

  @override
  Future<List<Pull>> getAllRepoPulls(
      String repoName, BuildContext context, AdminDashboardCache cache,) {
    // TODO: implement getAllRepoPulls
    throw UnimplementedError();
  }
}
