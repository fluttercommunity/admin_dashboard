import 'package:admin_dashboard/authentication/authentication.dart';
import 'package:admin_dashboard/dto/pull_model.dart';
import 'package:admin_dashboard/route/routes.dart';
import 'package:admin_dashboard/service/fire_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../authentication/authentication_service.dart';
import '../dto/adminDashboardCache_model.dart';
import '../dto/issue_model.dart';
import '../injection.dart';
import '../service/basic_service.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
//Build the interface using Consumer to pass the AdminDashboardCache to the LoginPageDetailsBody
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<AdminDashboardCache>  //Cache containing user ID is consumed
          (
            builder: (context, cache, _) {
              return LoginPageDetailsBody(cache);
            }
        )
    );
  }
}

  class LoginPageDetailsBody extends StatelessWidget {
    AdminDashboardCache cache;

   LoginPageDetailsBody(this.cache, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(title: '', cache: this.cache,),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  AdminDashboardCache cache;
  MyLoginPage({Key? key, required this.title, required this.cache}) : super(key: key);

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState(this.cache);
}

class _MyLoginPageState extends State<MyLoginPage> {
  AdminDashboardCache cache;
  final fire = getIt<BasicServiceInterface>();
  _MyLoginPageState(this.cache);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createPull(),
        tooltip: '',
        child: const Icon(Icons.add),
      ),
    );
  }

  createIssue() { //Test function for creating issues
    Issue issue = Issue(issueID: 250,state:"closed",title:"Test Issue",logged_at: DateTime.now(),closed_at: DateTime.now(),closed_by:"Amer",commentsNumber: 4,
        repository:"Flutter Test" );
     this.fire.addIssue(issue);

  }

  printUser(BuildContext context)async{ //Test function for logging into and displaying a user's github ID
    FirebaseAuthenticationService firebaseAuthenticationService = FirebaseAuthenticationService();
    String? uid = await firebaseAuthenticationService.githubLogin(context, this.cache);
    print('uid is '+uid!);
  }

  printRepoIssues(BuildContext context)async{ //Prints a list of all the avaliable issues in our firebase collection
    FireBaseService fireBaseService = FireBaseService();
    fireBaseService.getAllRepoIssues("/repos/fluttercommunity/plus_plugins/issues/", context, cache);
  }

  createPull() { //Test function for creating pull requests
    Pull pull = Pull(userId: 250,state:"closed",title:"Test Pull",logged_at: DateTime.now(),closed_at: DateTime.now(),closed_by:"Amer",commentsNumber: 4,
        repository:"Flutter Test" );
     this.fire.addPull(pull);
  }
}