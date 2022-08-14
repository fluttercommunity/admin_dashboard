import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/page/drawer_widget.dart';
import 'package:admin_dashboard/page/mobile_repo_details.dart';
import 'package:admin_dashboard/page/web_repo_details.dart';
import 'package:admin_dashboard/service/basic_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///state of the blank page
class RepoDetailsPage extends StatefulWidget {
  ///cache where the logged in user's ID is stored
  final AdminDashboardCache cache;

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  ///blank page
  const RepoDetailsPage({
    required this.cache,
    required this.firebaseApp,
    Key? key,
  }) : super(key: key);

  @override
  State<RepoDetailsPage> createState() =>
      _RepoDetailsPageState(cache, firebaseApp);
}

class _RepoDetailsPageState extends State<RepoDetailsPage> {
  _RepoDetailsPageState(this.cache, this.firebaseApp);

  FirebaseApp firebaseApp;
  AdminDashboardCache cache;

  // UnimplementedError() {
  //   void initState() {
  //     super.initState();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
    SimpleRepo simpleRepo = SimpleRepo(name: '');
    final args = ModalRoute.of(context)!.settings.arguments ?? simpleRepo;
    simpleRepo = args as SimpleRepo;
    if (myWidth >= 600) {
      return buildWide(context, simpleRepo, myWidth, myHeight);
    } else {
      return buildNarrow(context, simpleRepo, myWidth, myHeight);
    }
  }

  Widget buildNarrow(BuildContext context, SimpleRepo simpleRepo,
      double myWidth, double myHeight) {
    return NarrowRepoPage(cache, firebaseApp, simpleRepo, myWidth, myHeight);
  }

  Widget buildWide(BuildContext context, SimpleRepo simpleRepo, double myWidth,
      double myHeight) {
    return WideRepoPage(cache, firebaseApp, simpleRepo, myWidth, myHeight);
  }
}
