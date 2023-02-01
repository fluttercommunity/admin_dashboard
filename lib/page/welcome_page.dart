import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/page/drawer_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///Default page shown in our application
class WelcomePage extends StatefulWidget {
  ///welcome page constructor
  const WelcomePage({
    Key? key,
    //required this.fire,
    required this.firebaseApp,
  }) : super(key: key);
  ///Instance of firebaseApp
  final FirebaseApp firebaseApp;

  ///cache where the logged in user's ID is stored
  ///instance to handle firebase services
  //final BasicServiceInterface fire;

  @override
  State<WelcomePage> createState() => _WelcomePageState(//cache, //fire,
    firebaseApp,);
}

class _WelcomePageState extends State<WelcomePage> {
  _WelcomePageState(//this.cache, //this.fire,
      this.firebaseApp,);
  FirebaseApp firebaseApp;
  //AdminDashboardCache cache;
  //BasicServiceInterface fire;

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: DrawerWidget(//cache, //fire,
      firebaseApp,),
    appBar:  AppBar(
      title: const Text(Constants.welcomePageTitle),
      backgroundColor: Colors.deepPurpleAccent,
    ),
  );

}
