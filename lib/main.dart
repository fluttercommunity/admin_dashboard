import 'package:admin_dashboard/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: EnvironmentConfig.apiKey,
      appId: EnvironmentConfig.appId,
      messagingSenderId: EnvironmentConfig.messagingSenderId,
      projectId: EnvironmentConfig.projectId,
    ),
  );
  runApp(
    const ProviderScope(
      child: MyAppRoutes(),
    ),
  );
}

/// MyAppRoutes is the default page run at start up, it handles navigation
/// to the homepage and calls the class generateRoute when navigating
class MyAppRoutes extends ConsumerWidget {
  ///Key
  const MyAppRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      onGenerateTitle: (context) => 'Flutter Admin App',
      initialRoute: RouteGenerator.loginPage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

///environment variables
class EnvironmentConfig {
  ///logged in client ID which is stored as a environment variable
  static const clientId = String.fromEnvironment('admin_dashboard_clientId');
  ///logged in client Secret which is stored as a environment variable
  static const clientSecret =
      String.fromEnvironment('admin_dashboard_clientSecret');
  ///The environment variable containing the redirect URL of GitHub
  static const redirectUrl =
      String.fromEnvironment('admin_dashboard_redirectUrl');
  ///logged in client Token which is stored as a environment variable
  static const token = String.fromEnvironment('admin_dashboard_token');
  static const apiKey = String.fromEnvironment('apiKey');
  static const appId = String.fromEnvironment('appId');
  static const messagingSenderId = String.fromEnvironment('messagingSenderId');
  static const projectId = String.fromEnvironment('projectId');
}
