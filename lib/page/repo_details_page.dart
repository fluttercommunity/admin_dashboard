import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/page/mobile_repo_details.dart';
import 'package:admin_dashboard/page/web_repo_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///Page that displays a repository's details
class RepoDetailsPage extends StatefulWidget {

  ///Constructor
  const RepoDetailsPage({
    required this.firebaseApp,
    Key? key,
  }) : super(key: key);

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  @override
  State<RepoDetailsPage> createState() =>
      _RepoDetailsPageState( firebaseApp);
}

class _RepoDetailsPageState extends State<RepoDetailsPage> {
  _RepoDetailsPageState( this.firebaseApp);

  FirebaseApp firebaseApp;

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
    var simpleRepo = SimpleRepo(name: '');
    final args = ModalRoute.of(context)!.settings.arguments ?? simpleRepo;
    simpleRepo = args as SimpleRepo;
    if (myWidth >= 600) {
      return buildWide(context, simpleRepo, myWidth, myHeight);
    } else {
      return buildNarrow(context, simpleRepo, myWidth, myHeight);
    }
  }

  Widget buildNarrow(BuildContext context, SimpleRepo simpleRepo,
      double myWidth, double myHeight,) {
    return NarrowRepoPage(firebaseApp, simpleRepo, myWidth, myHeight);
  }

  Widget buildWide(BuildContext context, SimpleRepo simpleRepo, double myWidth,
      double myHeight,) {
    return WideRepoPage( firebaseApp, simpleRepo, myWidth, myHeight);
  }
}
