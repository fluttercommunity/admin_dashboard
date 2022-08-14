import 'package:admin_dashboard/authentication/authentication.dart';
import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/issue_model.dart';
import 'package:admin_dashboard/dto/pull_model.dart';
import 'package:admin_dashboard/provider/provider_list.dart';
import 'package:admin_dashboard/service/basic_service.dart';
import 'package:admin_dashboard/service/fire_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../route/routes.dart';


///state of the login page
class LoginPage extends StatefulWidget {


  ///login page
   const LoginPage({
    Key? key,
    required this.cache,
    required this.firebaseApp,
  }) : super(key: key);
  final FirebaseApp firebaseApp;
  final AdminDashboardCache cache;


  @override
  State<LoginPage> createState() => _LoginPageState(cache, firebaseApp);
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState(this.cache, this.firebaseApp):
        this.firebaseAuthenticationService =
        FirebaseAuthenticationService(firebaseApp);
  AdminDashboardCache cache;
  final FirebaseApp firebaseApp;
  FirebaseAuthenticationService firebaseAuthenticationService;
  bool isBusy = false;
  bool isLoggedIn = false;
  bool enableButton = true;
  @override
  void initState() {
    print("hello");
    // print(FirebaseAuth.instance);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //todo change
        title: Text('Login Page'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child:  isBusy
            ? CircularProgressIndicator()
        : isLoggedIn? Text(""):
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            primary: Colors.deepPurpleAccent,
            onPrimary: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: loginAction,
          child: Text('Login'),

        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).pushNamed(RouteGenerator.welcomePage)
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  loginAction()async {
    setState(() {
      isBusy = true;
      enableButton = false;
    });
    final result = await firebaseAuthenticationService.githubLogin(
        context, cache);
    result == null ? Navigator.pushNamed(context, RouteGenerator.waitingPage)
        : Navigator.pushReplacementNamed(context, RouteGenerator.welcomePage);
    //Navigator.pushReplacementNamed(context, RouteGenerator.processPage);
    if(result!=null)
      // print(result);
    setState(() {
      isBusy = false;
      enableButton = true;
    if(result==null){
      print("Result is null!");
    }
    });
  }
}


class WaitingPage extends StatelessWidget {

  ///login page
  const WaitingPage({
    Key? key,
    required this.cache,
    required this.firebaseApp,
  }) : super(key: key);
  final FirebaseApp firebaseApp;
  final AdminDashboardCache cache;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: CircularProgressIndicator(),)

    );
  }



}