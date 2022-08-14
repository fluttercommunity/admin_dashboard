//final result = await firebaseAuthenticationService.githubLogin(context, cache);
//             result == null  ? Navigator.pushNamed(context, RouteGenerator.loginPage)
//                 : Navigator.pushReplacementNamed(context, RouteGenerator.welcomePage);



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../authentication/authentication.dart';
import '../dto/admin_dashboard_cache_model.dart';
import '../route/routes.dart';

class ProcessLoginPage extends StatefulWidget {

  ///login page
  const ProcessLoginPage({
    Key? key,
    required this.cache,
    required this.firebaseApp,
  }) : super(key: key);
  final FirebaseApp firebaseApp;
  final AdminDashboardCache cache;
  @override
  State<ProcessLoginPage> createState() => _ProcessLoginPage(cache, firebaseApp);
}

//final result = firebaseAuthenticationService.githubLogin(context, cache);
class _ProcessLoginPage extends State<ProcessLoginPage> {
  _ProcessLoginPage(this.cache, this.firebaseApp):
        this.firebaseAuthenticationService =
                    FirebaseAuthenticationService(firebaseApp);
  AdminDashboardCache cache;
  final FirebaseApp firebaseApp;
  late Future<String?> uid;
  FirebaseAuthenticationService firebaseAuthenticationService;


  @override
  void initState() {
    super.initState();
    // uid = firebaseAuthenticationService.githubLogin(context, cache);
  }

  @override
  Widget build(BuildContext context) {

    return  SigninWidget(firebaseApp, firebaseAuthenticationService);

    //   Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.amber,
    //     //todo change
    //     title: Text('Login in Progress'),
    //   ),
    //   body: SigninWidget()
    //
    // );
  }
}

class SigninWidget extends StatelessWidget{
  FirebaseAuthenticationService firebaseAuthenticationService;
  FirebaseApp firebaseApp;
  SigninWidget(this.firebaseApp, this.firebaseAuthenticationService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instanceFor(app: firebaseApp).authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError){
            //TODO change
            return Center(child: Text('An Error has occured'),);
          }  else {
            return Center(child: Text('OK'),);
          }
        },
      ),
    );
  }
  
}

//Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: FutureBuilder<String?>(
//               future: uid,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasData) {
//                     final result = snapshot.data!.toString();
//                         return (result==null)?Text('UID is NULL'):Text('$result');
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }
//                 }
//                 return const CircularProgressIndicator();
//               } )
//
//       ),