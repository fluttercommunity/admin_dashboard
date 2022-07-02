import 'package:admin_dashboard/authentication/authentication_service.dart';
import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_sign_in/github_sign_in.dart';

///Providing Authentication Service via Firebase
class FirebaseAuthenticationService implements AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String?> emailLogin(String email, String password) async {
    UserCredential userCredential;
    userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user?.uid;
  }

  @override
  ///Handles login through Github interface, stores UID in admin_dashboard_cache
  Future<String?> githubLogin(
      BuildContext context, AdminDashboardCache cache,) async {
    // Create a GitHubSignIn instance

    final GitHubSignIn gitHubSignIn;
    gitHubSignIn = GitHubSignIn(
      clientId: EnvironmentConfig.clientId,
      clientSecret: EnvironmentConfig.clientSecret,
      redirectUrl: EnvironmentConfig.redirectUrl,
    );

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);
    // if the login is valid,
    // store uid in AdminDashboardCache and authenticate using firebase
    if (result.token != null) {
      cache.uid = gitHubSignIn.clientId;
      // Create a credential from the access token
      final githubAuthCredential =
          GithubAuthProvider.credential(result.token ?? '');
      UserCredential userCredential;
      userCredential = await FirebaseAuth.instance
          .signInWithCredential(githubAuthCredential);
      return userCredential.user?.uid;
      // Once signed in, return the UserCredential
    }
    return null;
  }

  ///fetches currently signed in user via FirebaseAuth
  Future<User?> getFirebaseUser() async {
    return _firebaseAuth.currentUser;
  }
}
