import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/route/routes.dart';
import 'package:flutter/material.dart';

///Element that is used in the list of repos, where a list of all repos are
///displayed
class RepoListElement{
  ///Constructor
  RepoListElement(this.simpleRepo, this.width,  this.index);
  ///Instance of simpleRepo
  SimpleRepo simpleRepo;
  ///Width of the screen
  double width;
  ///Index to change color every other list element
  int index;
  ///Background color for list elements
  late Color backgroundColor =
  (index.isEven)? Colors.blueAccent:Colors.deepPurpleAccent;
  ///Repo list build method
  Widget build(BuildContext context, AdminDashboardCache cache){
    return ElevatedButton(
      onPressed: () {
        cache.simpleRepo = simpleRepo;
        Navigator.pushReplacementNamed(
          context,
          RouteGenerator.repoDetailsPage,
        );
      },
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: Colors.black,
        maximumSize: Size(width*0.7, 80),
      ), child: Text(
        ' ${simpleRepo.name.replaceAll(RegExp('/fluttercommunity/'),'')}',),);
  }
}
