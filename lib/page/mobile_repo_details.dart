
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dto/admin_dashboard_cache_model.dart';
import '../dto/repo_model.dart';
import 'drawer_widget.dart';

class NarrowRepoPage extends StatelessWidget {
  final AdminDashboardCache cache;

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  final SimpleRepo simpleRepo;

  final double myWidth;
  final double myHeight;

  NarrowRepoPage(this.cache, this.firebaseApp, this.simpleRepo, this.myWidth,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: myHeight / 10,
              color: Colors.white,
              child: const Card(
                  color: Colors.blueAccent,
                  child: Center(child: Text('Issues with need help'))),
            ),
            Container(
              width: double.infinity,
              height: myHeight / 10,
              color: Colors.white,
              child: const Card(
                  color: Colors.deepPurpleAccent,
                  child: Center(
                    child: Text('PRs with documentation'),
                  )),
            ),
            Container(
              width: double.infinity,
              height: myHeight / 10,
              color: Colors.white,
              child: const Card(
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text('Issues with bug fix'),
                  )),
            ),
            Container(
              width: double.infinity,
              height: myHeight / 10,
              color: Colors.white,
              child: const Card(
                  color: Colors.deepPurpleAccent,
                  child: Center(child: Text('PRS with bug fix'))),
            ),
            Container(
              width: double.infinity,
              height: myHeight / 2,
              color: Colors.white,
              child: Card(
                  color: Colors.white, child: Image.asset('images/pp.jpg')),
            ),
            Container(
              width: double.infinity,
              height: myHeight / 10,
              color: Colors.white,
              child: const Card(
                  color: Colors.deepPurpleAccent,
                  child: Center(
                      child: Center(child: Text('Issues with enhancement')))),
            ),
            Container(
              width: double.infinity,
              height: myHeight / 10,
              color: Colors.white,
              child: const Card(
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text('PR with android'),
                  )),
            ),
            Container(
              width: double.infinity,
              height: myHeight / 10,
              color: Colors.white,
              child: const Card(
                  color: Colors.deepPurpleAccent,
                  child: Center(child: Text('Issues with question'))),
            ),
            Container(
              width: double.infinity,
              height: myHeight / 10,
              color: Colors.white,
              child: const Card(
                  color: Colors.blueAccent,
                  child: Center(child: Text('PR with IOS'))),
            ),
          ],
        ),
      ),
    );
  }
}
