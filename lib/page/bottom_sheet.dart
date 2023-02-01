import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
///Bottom sheet where the repo owner, status and name are displayed
class BottomSheet extends StatelessWidget{
  ///Constructor
  const BottomSheet( this.cache, this.firebaseApp, this.simpleRepo,
      {Key? key,}):super(key: key);

  ///Instance of our admin dashboard's cache
  final AdminDashboardCache cache;

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  ///Instance of simpleRepo object used in the repository page
  final SimpleRepo simpleRepo;
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
                  child: const Text(Constants.statusWord),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: const Text(Constants.owner),
                ),
                const Spacer(),
              ],
            ),
        ),
    );
  }
}
