import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/page/issue_details_mobile.dart';
import 'package:admin_dashboard/page/issue_details_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///state of the issue details page
class IssueDetailsPage extends StatefulWidget {
  ///Issue page constructor
  const IssueDetailsPage({
    required this.firebaseApp,
    Key? key,
  }) : super(key: key);

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  @override
  State<IssueDetailsPage> createState() =>
      _IssueDetailsPageState( firebaseApp, );
}

class _IssueDetailsPageState extends State<IssueDetailsPage> {
  _IssueDetailsPageState( this.firebaseApp, );

  FirebaseApp firebaseApp;

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery
        .of(context)
        .size
        .width;
    final myHeight = MediaQuery
        .of(context)
        .size
        .height;
    var simpleRepo = SimpleRepo(name: '');
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments ?? simpleRepo;
    simpleRepo = args as SimpleRepo;
    if (myWidth >= 600) {
      return buildWide(context, simpleRepo, myWidth, myHeight);
    } else {
      return buildNarrow(context, simpleRepo, myWidth, myHeight);
    }
  }
  Widget buildNarrow(BuildContext context, SimpleRepo simpleRepo,
      double myWidth, double myHeight,) {
    return NarrowIssuePage(firebaseApp, simpleRepo, myWidth, myHeight);
  }

  Widget buildWide(BuildContext context, SimpleRepo simpleRepo, double myWidth,
      double myHeight,) {
    return WideIssuePage(firebaseApp, simpleRepo, myWidth, myHeight,  );
  }
}
