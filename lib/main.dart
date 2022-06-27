import 'package:admin_dashboard/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'dto/adminDashboardCache_model.dart';
import 'injection.dart';



Future<void> main() async {
  configureInjection(Env.prod);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAppRoutes());
}

//MyAppRoutes is the default page run at start up, it handles navigation to the homepage and calls the class generateRoute when navigating
class MyAppRoutes extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Provider<AdminDashboardCache>( //Cache where we will store the user's login ID
      create: (context) => AdminDashboardCache(),
      child: MaterialApp(
        onGenerateTitle: (context) => "Random App",
        initialRoute: RouteGenerator.loginPage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

//@singleton
class EnvironmentConfig { //environment variables
  static const clientId = String.fromEnvironment('admin_dashboard_clientId');
  static const clientSecret = String.fromEnvironment('admin_dashboard_clientSecret');
  static const redirectUrl = String.fromEnvironment('admin_dashboard_redirectUrl');
  static const token = String.fromEnvironment('admin_dashboard_token');
}
