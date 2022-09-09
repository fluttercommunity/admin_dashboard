import 'package:admin_dashboard/authentication/authentication_service.dart';
import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_sign_in/github_sign_in.dart';

///Providing Authentication Service via Firebase
class FirebaseAuthenticationService implements AuthenticationService {
  ///Constructor that takes firebaseApp as a parameter
  FirebaseAuthenticationService(this.firebaseApp);

  ///Instance of firebaseApp
  FirebaseApp firebaseApp;


  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String?> emailLogin(String email, String password) async {
    final firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
    UserCredential userCredential;
    userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user?.uid;
  }

  @override
  ///Handles login through Github interface, stores UID in admin_dashboard_cache
  Future<UserCredential> githubLogin(
      BuildContext context, AdminDashboardCache cache,) async {
    // Create a new provider
    final githubProvider = GithubAuthProvider();

    //https://firebase.flutter.dev/docs/auth/usage/

    if(cache.isWeb) {
      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) {
      });
      await FirebaseAuth.instance.setPersistence(Persistence.NONE);
      // Once signed in, return the UserCredential
      final userCredential =
      await FirebaseAuth.instance.signInWithPopup(githubProvider);
      // debugPrint(userCredential.toString());
      return userCredential;
    }
    else {
      //Create a GitHubSignIn instance
      try {
        debugPrint('Step 1');
        final GitHubSignIn gitHubSignIn;
        gitHubSignIn = GitHubSignIn(
          clientId: EnvironmentConfig.clientId,
          clientSecret: EnvironmentConfig.clientSecret,
          redirectUrl: EnvironmentConfig.redirectUrl,
        );
        debugPrint('Step 2');

        // Trigger the sign-in flow
        final result = await gitHubSignIn.signIn(context);
        debugPrint('Step 3');
        // if the login is valid,
        // store uid in AdminDashboardCache and authenticate using firebase
        if (result.token != null) {
          debugPrint('Step 4');
          cache..uid = gitHubSignIn.clientId
          ..loggedIn = true;
          // Create a credential from the access token
          final githubAuthCredential =
          GithubAuthProvider.credential(result.token ?? '');
          UserCredential userCredential; //local variable for debugging
          return userCredential = await FirebaseAuth.instance
              .signInWithCredential(githubAuthCredential);
          // Once signed in, return the UserCredential
        }
        throw Exception('Error logging in');

      }catch(e){
        debugPrint(e.toString());
        rethrow;
      }
    }
  }
}
