import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dto/repo_model.dart';

class BottomSheet extends StatelessWidget{
  final AdminDashboardCache cache;

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  final SimpleRepo simpleRepo;

  BottomSheet(this.cache, this.firebaseApp, this.simpleRepo);
  Widget buildBottomSheet(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 5000,
          minWidth: 150,
          minHeight: 20,
        ),
        child: BottomAppBar(
            color: Colors.black12,
            child: Row(
              children: <Widget>[
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Text(cache.simpleRepo.name),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: const Text('Status'),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: const Text('     Owner'),
                ),
                const Spacer(),
              ],
            )
        )
    );
  }

  throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}