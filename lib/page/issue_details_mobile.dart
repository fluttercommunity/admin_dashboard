
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dto/admin_dashboard_cache_model.dart';
import '../dto/repo_model.dart';
import 'drawer_widget.dart';

class NarrowIssuePage extends StatelessWidget {
  final AdminDashboardCache cache;

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  final SimpleRepo simpleRepo;

  final double myWidth;
  final double myHeight;

  NarrowIssuePage(this.cache, this.firebaseApp, this.simpleRepo, this.myWidth,
      this.myHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        cache,
        firebaseApp,
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Text("test")
    );
  }
}
