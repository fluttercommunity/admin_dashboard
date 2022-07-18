import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/provider/provider_list.dart';
import 'package:admin_dashboard/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'environmentVariables.env');
  await Firebase.initializeApp(
    name: Constants.projectName,
    options:  FirebaseOptions(
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
    final cache = ref.read(cacheProvider);
    final fire = ref.read(fireBaseService);
    return MaterialApp(
      onGenerateTitle: (context) => Constants.welcomePageTitle,
      initialRoute: RouteGenerator.welcomePage,
      onGenerateRoute: //RouteGenerator.generateRoute,
          (settings) {
                  return RouteGenerator.generateRoute(settings, cache, fire);
                },
      debugShowCheckedModeBanner: false,
    );
  }
}

///environment variables
class EnvironmentConfig {
  ///logged in client Token which is stored as a environment variable
  static final token = dotenv.get('MY_ADMIN_DASHBOARD_TOKEN', fallback:
  'no .env',);
  ///logged in client ID which is stored as a environment variable
  static final clientId =
  dotenv.get('MY_ADMIN_DASHBOARD_CLIENTID', fallback: 'no .env');
  ///logged in client Secret which is stored as a environment variable
  static final clientSecret =
  dotenv.get('MY_ADMIN_DASHBOARD_CLIENTSECRET', fallback: 'no .env');
  ///The environment variable containing the redirect URL of GitHub
  static final redirectUrl =
  dotenv.get('MY_ADMIN_DASHBOARD_REDIRECTURL', fallback: 'no .env');
  ///our firebase's API key as an environment variable
  static final apiKey = dotenv.get('MY_APIKEY', fallback: 'no .env');
  ///our android appID from the firebase console as an environment variable
  static final appId = dotenv.get('MY_APPID', fallback: 'no .env');
  ///our messagingSenderID from the firebase console as an environment variable
  static final messagingSenderId =
  dotenv.get('MY_MESSAGINGSENDERID', fallback: 'no .env');
  ///Our projectID from the firebase console as an environment variable
  static final projectId = dotenv.get('MY_PROJECTID', fallback: 'no .env');

}
