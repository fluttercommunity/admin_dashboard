import 'dart:convert';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/issue.dart';
import 'package:admin_dashboard/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

///class that handles retrieving data from github API
class GithubService{

  ///Retrieves all issues in a repository
  Future<List<SimpleIssue>> getAllIssuesOfRepo(
      String repoName,
      ) async {
    final result = <SimpleIssue>[];
    final url =
    Uri.parse('${Constants.repoGitUrl}$repoName${Constants.repoGitIssue}');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${EnvironmentConfig.token}',
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
      SimpleIssue myIssue;
      for (final element in issueList) {
        Map<String, Object?> issue;
        issue = element as Map<String, Object?>;
        //debugPrint("id=${issue['id'] ?? "null"}");
        debugPrint("title=${issue['title'] ?? "null"}");
        debugPrint("url=${issue['url'] ?? "null"}");
        debugPrint("state=${issue['state'] ?? "null"}");
        debugPrint("comments=${issue['comments'] ?? "null"}");
        debugPrint("created_at=${issue['created_at'] ?? "null"}");
        debugPrint("updated_at=${issue['updated_at'] ?? "null"}");




        myIssue = SimpleIssue(title: issue['title']!.toString(),
          url: issue['url']!.toString(),
          state: issue['state']!.toString(),
          comments: int.tryParse(issue['comments']!.toString()) ?? 0,
          createdAt:
          DateTime.tryParse(issue['created_at']!.toString()) ?? DateTime.now(),
          updatedAt:
          DateTime.tryParse(issue['updated_at']!.toString()) ?? DateTime.now(),
        );

        debugPrint(myIssue.toString());
        debugPrint('\n********************************\n');
        result.add(myIssue);

      }
      //debugPrint(result.toString());
      return result;
    } catch (error) {
      rethrow;
    }
  }
}
