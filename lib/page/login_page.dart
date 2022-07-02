import 'package:admin_dashboard/authentication/authentication.dart';
import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/issue_model.dart';
import 'package:admin_dashboard/dto/pull_model.dart';
import 'package:admin_dashboard/provider/provider_list.dart';
import 'package:admin_dashboard/service/basic_service.dart';
import 'package:admin_dashboard/service/fire_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Initial page that prompts user to log in, default page shown
class LoginPage extends ConsumerWidget {
  ///Build interface using Consumer to pass AdminDashboardCache
  /// to LoginPageDetailsBody
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cache = ref.read(cacheProvider);
    final fire = ref.read(fireBaseService);

    return Scaffold(
      body: LoginPageDetailsBody(cache, fire),
    );
  }
}
///Details of the Login page's body
class LoginPageDetailsBody extends StatelessWidget {
  ///key
  const LoginPageDetailsBody(this.cache, this.fire, {Key? key})
      : super(key: key);
  ///cache where the logged in user's ID is stored
  final AdminDashboardCache cache;
  ///instance to handle firebase services
  final BasicServiceInterface fire;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(cache: cache, fire: fire),
    );
  }
}

///state of the login page
class MyLoginPage extends StatefulWidget {
  ///login page
  const MyLoginPage({
    Key? key,
    required this.cache,
    required this.fire,
  }) : super(key: key);
  ///Cache where userID and token are stored
  final AdminDashboardCache cache;
  ///Instance variable of Firebase service
  final BasicServiceInterface fire;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState(cache, fire);
}

class _MyLoginPageState extends State<MyLoginPage> {
  _MyLoginPageState(this.cache, this.fire);
  AdminDashboardCache cache;
  BasicServiceInterface fire;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createIssue,
        //printRepoIssues(context),
        tooltip: '',
        child: const Icon(Icons.add),
      ),
    );
  }

  ///Test function for creating issues and storing in our firebase collection
  void createIssue() {
    Issue issue;
    issue = Issue(
      issueID: 250,
      state: 'closed',
      title: 'Test Issue',
      loggedAt: DateTime.now(),
      closedAt: DateTime.now(),
      closedBy: 'Amer',
      commentsNumber: 4,
      repository: Constants.repoNameTest ,
    );
    fire.addIssue(issue);
  }
  ///Test function for logging into and displaying a user's github ID
  Future<void> printUser(BuildContext context) async {
    FirebaseAuthenticationService firebaseAuthenticationService;
    firebaseAuthenticationService = FirebaseAuthenticationService();
    String? uid;
    uid = await firebaseAuthenticationService.githubLogin(context, cache);
    debugPrint('uid is ${uid!}');
  }
  /// Test function,
  /// Prints a list of all the available issues in our firebase collection
  Future<void> printRepoIssues(BuildContext context) async {
    FireBaseService fireBaseService;
    fireBaseService = FireBaseService();
    await fireBaseService.getAllRepoIssues(
        '/repos/fluttercommunity/plus_plugins/issues', context, cache,);
  }

  ///Test function for creating pull requests
  void createPull() {
    Pull pull;
    pull = Pull(
      userId: 250,
      state: 'closed',
      title: 'Test Pull',
      loggedAt: DateTime.now(),
      closedAt: DateTime.now(),
      closedBy: 'Amer',
      commentsNumber: 4,
      repository: 'Flutter Test',
    );
    fire.addPull(pull);
  }
}
