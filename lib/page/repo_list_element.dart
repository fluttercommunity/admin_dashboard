import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:flutter/material.dart';

import '../dto/admin_dashboard_cache_model.dart';
import '../route/routes.dart';

class RepoListElement{
  RepoListElement(this.simpleRepo, this.width,  this.index);
  SimpleRepo simpleRepo;
  double width;
  int index;
  late Color backgroundColor =(index%2 == 0)?Colors.blueAccent:Colors.deepPurpleAccent;

  Widget build(BuildContext context, AdminDashboardCache cache){
    return ElevatedButton(
          onPressed: () {
            cache.simpleRepo = simpleRepo;
            Navigator.pushNamed(
              context,
              RouteGenerator.repoDetailsPage,
              // arguments: simpleRepo,
            );
          },
          style: ElevatedButton.styleFrom(
          primary: backgroundColor, // background (button) color
          onPrimary: Colors.black,// background (text) color
          maximumSize: Size(width*0.7, 80),
          ), child: Text(' ${simpleRepo.name}'),);
  }
}
