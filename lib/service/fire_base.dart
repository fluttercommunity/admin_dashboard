import 'dart:convert';

import 'package:admin_dashboard/dto/adminDashboardCache_model.dart';
import 'package:admin_dashboard/dto/issue_model.dart';
import 'package:admin_dashboard/dto/pull_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../view_util.dart';
import 'basic_service.dart';
import 'package:http/http.dart' as http;
import 'package:admin_dashboard/dto/constant.dart';


@injectable
class FireBaseService implements BasicServiceInterface{
  @override
  Future<Issue> addIssue(Issue issue) async {
    String repoNameTest = Constants.REPONAMETEST;
    String issues = Constants.ISSUES;
    String siteUrl = 'https://admin-dashboard-b9503-default-rtdb.firebaseio.com/activity_log/' + repoNameTest +"/"+ issues + '.json';
    try {
      final urlChat = Uri.parse(siteUrl);
      Issue issue = Issue(issueID: 250,state:"closed",title:"Test Issue",logged_at: DateTime.now(),closed_at: DateTime.now(),closed_by:"Amer",commentsNumber: 4,
          repository:"Flutter Test");
      print(issue.toJson());
      var response2 = await http.post(urlChat, body: json.encode(issue.toJson()));
      print(response2.statusCode);
      return issue;
    } catch (error) {
      rethrow;
    }
    {
    throw UnimplementedError();
    }
  }

  @override
  List<Issue> getAllIssues() {
    // TODO: implement getAllIssues
    throw UnimplementedError();
  }

  @override
  @JsonSerializable()
  Future<List<Issue>> getAllRepoIssues(String repoName, BuildContext context, AdminDashboardCache cache) async {
    List<Issue>? result = [];
    final url = Uri.parse("https://api.github.com$repoName/issues");
    print("url=$url");
    try {
      final response = await http.get(url,
        headers: {
          "Authorization": "Bearer " + cache.token,
        },
      );
      if(response.statusCode!= 200) {
        return result;
      }

      var body = response.body;
      if(body == "null"){
        return result;
      }
      List<dynamic> issues = json.decode(response.body);
      for(Map<String, Object?> issue in issues) {
        print("id="+ (issue['id']==null?"null":issue['id']).toString());
        print("title="+ (issue['title']==null?"null":issue['title']).toString());
      }
      return result;

    } catch (error) {
      throw error;
    }
  }

  @override
  Future<Pull> addPull(Pull pr) async {
    DateTime now = DateTime.now();
    String repoNameTest = Constants.REPONAMETEST;
    String pulls = Constants.PULLS;
    String siteUrl = 'https://admin-dashboard-b9503-default-rtdb.firebaseio.com/activity_log/' + repoNameTest +"/"+ pulls + '.json';
    try {
      final urlChat = Uri.parse(siteUrl);
      Pull pull = Pull(userId: 250,state:"closed",title:"Test PR",logged_at: DateTime.now(),closed_at: DateTime.now(),closed_by:"Amer",commentsNumber: 4,
          repository:"Flutter Test");
      print(pull.toJson());
      var response2 = await http.post(urlChat, body: json.encode(pull.toJson()));
      print(response2.statusCode);
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
  Future<List<Pull>> getAllRepoPulls(String repoName, BuildContext context, AdminDashboardCache cache) {
    // TODO: implement getAllRepoPulls
    throw UnimplementedError();
  }
}