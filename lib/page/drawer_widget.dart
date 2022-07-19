import 'package:admin_dashboard/authentication/authentication.dart';
import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/route/routes.dart';
import 'package:admin_dashboard/service/fire_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///Drawer widget that is used for navigation throughout the app
class DrawerWidget extends StatelessWidget {
  ///Constructor for the drawer widget

  const DrawerWidget(this.cache,// this.fire,
      this.firebaseApp, {Key? key,}) : super(key: key);
  ///Instance of firebaseApp
  final FirebaseApp firebaseApp;

  ///Our cache that is used throughout the app
 final AdminDashboardCache cache;
  ///
 //final BasicServiceInterface fire;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
            color: Colors.blue,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 48),
                buildMenuItem(
                  text: Constants.login,
                  icon: Icons.add,
                  onClicked: () =>  {login(context)},
                ),
                //
                buildMenuItem(text: Constants.printRepos,
                    icon: Icons.add,
                  onClicked: () =>{
                  Navigator.of(context).pushNamed(RouteGenerator.repoPage)
                  },
                ),
              ],
            ),
        ),
    );
  }
  ///Build for items in the drawer widget
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      onTap: onClicked,
    );
  }
  ///Prints a list of all repos in a specific organization
  Future<List<SimpleRepo>> printRepos(BuildContext context) async {
    FireBaseService fireBaseService;
    fireBaseService = FireBaseService(firebaseApp);

    final list = await fireBaseService.getAllRepos(
        context,
        cache,
    );
    return list;
  }
  ///Function that handles logging in via github's API, calls githubLogin
  Future<void> login(BuildContext context) async {
    FirebaseAuthenticationService firebaseAuthenticationService;
    // print("Step A");
    firebaseAuthenticationService = FirebaseAuthenticationService(firebaseApp);
    // print("Step B");
    String? uid;
    uid = await firebaseAuthenticationService.githubLogin(context, cache);
    // print("Step C");
    debugPrint('uid is ${uid!}');
  }
}
