import 'package:admin_dashboard/authentication/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_sign_in/github_sign_in.dart';

import '../dto/adminDashboardCache_model.dart';
import '../dto/issue_model.dart';
import '../main.dart';


class FirebaseAuthenticationService implements AuthenticationService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String?> emailLogin(String email, String password) async{
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password
    );
    return userCredential.user?.uid;
  }

  @override
  Future<String?> githubLogin(BuildContext context, AdminDashboardCache cache) async {
    // Create a GitHubSignIn instance

    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: EnvironmentConfig.clientId,
        clientSecret: EnvironmentConfig.clientSecret,
        redirectUrl: EnvironmentConfig.redirectUrl

    );

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    if(result.token != null){ //if the login is valid, store uid in AdminDashboardCache and authenticate using firebase
      cache.uid = gitHubSignIn.clientId;
      final githubAuthCredential = GithubAuthProvider.credential(result.token??""); // Create a credential from the access token
      UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
      return userCredential.user?.uid; // Once signed in, return the UserCredential
    }
  }

  Future<User?> getFirebaseUser() async {
    User? user = _firebaseAuth.currentUser; //fetches currently signed in user via FirebaseAuth
    return user;
  }

}