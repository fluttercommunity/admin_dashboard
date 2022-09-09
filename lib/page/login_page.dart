import 'package:admin_dashboard/authentication/authentication.dart';
import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/provider/provider_list.dart';
import 'package:admin_dashboard/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Default page displayed for a user to login to the application
class LoginPage extends ConsumerWidget{
  ///Login page constructor
  const LoginPage({
    required this.firebaseApp,
  });
  ///Instance of firebase app
  final FirebaseApp firebaseApp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cache  = ref.read(cacheProvider);
    return LoginWidget(firebaseApp: firebaseApp, cache: cache,);
  }

}

///state of the login page
class LoginWidget extends StatefulWidget {


  ///login page
  const LoginWidget({
    Key? key,
    required this.cache,
    required this.firebaseApp,
  }) : super(key: key);
  ///Instance of firebase app
  final FirebaseApp firebaseApp;
  ///Instance of admin dashboard cache
  final AdminDashboardCache cache;


  @override
  State<LoginWidget> createState() => _LoginWidgetState(cache, firebaseApp);
}

class _LoginWidgetState extends State<LoginWidget> {
  _LoginWidgetState(this.cache, this.firebaseApp):
        firebaseAuthenticationService =
        FirebaseAuthenticationService(firebaseApp);
  AdminDashboardCache cache;
  final FirebaseApp firebaseApp;
  FirebaseAuthenticationService firebaseAuthenticationService;
  bool isBusy = false;
  bool isLoggedIn = false;
  bool enableButton = true;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //todo change
        title: const Text(Constants.loginPage),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child:  isBusy
            ? const CircularProgressIndicator()
            : isLoggedIn? const Text(''):
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            primary: Colors.deepPurpleAccent,
            onPrimary: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: loginAction,
          child: const Text(Constants.login),

        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).pushReplacementNamed(
              RouteGenerator.issueDetailPage,)
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  loginAction() async {
    setState(() {
      isBusy = true;
      enableButton = false;
    });
    final result = await firebaseAuthenticationService.githubLogin(
        context, cache,);
    result == null ? Navigator.pushReplacementNamed(context,
        RouteGenerator.waitingPage,)
        : Navigator.pushReplacementNamed(context,
        RouteGenerator.welcomePage,);
    if(result!=null) {
      setState(() {
        isBusy = false;
        enableButton = true;
        if(result==null){
        }
      });
    }
  }
}

///Displays a circular progress indicator while login is completed
class WaitingPage extends StatelessWidget {

  ///login page
  const WaitingPage({
    Key? key,
    required this.firebaseApp,
  }) : super(key: key);
  ///Instancce of firebase App
  final FirebaseApp firebaseApp;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:  Center(child: CircularProgressIndicator(),),
    );
  }
}
