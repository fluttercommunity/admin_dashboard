import 'package:admin_dashboard/authentication/authentication.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///Drawer widget that is used for navigation throughout the app
class DrawerWidget extends StatelessWidget{
  ///Constructor for the drawer widget

  const DrawerWidget(
      this.firebaseApp, {Key? key,}) : super(key: key);
  ///Instance of firebaseApp
  final FirebaseApp firebaseApp;

  @override
  Widget build(BuildContext context) {

    return buildLoggedIn(context);
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
  ///the login method
  Future<void> login(BuildContext context) async {
   FirebaseAuthenticationService(firebaseApp);
  }

  ///Build drawer widget for when a user isn't logged in
  Widget buildNotLoggedIn(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.deepPurple,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 48),
            buildMenuItem(
              text: Constants.login,
              icon: Icons.play_arrow,
              onClicked: () =>  {login(context)},
            ),
            //
            buildMenuItem(text: Constants.printRepos,
              icon: Icons.play_arrow,
              onClicked: () =>{
                Navigator.of(context).pushReplacementNamed(
                    RouteGenerator.repoPage,)
              },
            ),
            buildMenuItem(text: 'placeholder',
                icon: Icons.abc,
                onClicked: () => {
                },
            ),
          ],
        ),
      ),
    );

  }
  ///Drawer widget if the user is logged in
  Widget buildLoggedIn(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.deepPurple,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 48),
            //
            buildMenuItem(text: Constants.printRepos,
              icon: Icons.play_arrow,
              onClicked: () =>{
                Navigator.of(context).pushReplacementNamed(
                    RouteGenerator.repoPage,)
              },
            ),
          ],
        ),
      ),
    );

  }
}
