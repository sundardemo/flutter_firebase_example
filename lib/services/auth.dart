import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/services/user.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: []);

  void login(context, email, password) async {
    try {
      var res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (res.user!.uid != null) {
        print(res.user!.uid);
        Navigator.pushNamed(context, '/home');
        if (res.user!.emailVerified) {
          print("Verified User");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void register(context, name, email, password) async {
    try {
      var res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (res.user!.uid != null) {
        print(res.user!.uid);
        res.user!.sendEmailVerification();
        UserService().createUser(res.user!.uid, name, email);
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      print(e);
    }
  }

  void loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: []);
    var user = await _googleSignIn.signIn();
    if (user != null) {
      print(user.displayName);
      print(user.email);
      print(user.photoUrl);
    }
  }

  void loginWithFacebook() async {
    var loginData = await FacebookAuth.instance.login();
    if (loginData != null) {
      print(loginData.accessToken);
      var userData = await FacebookAuth.instance.getUserData();
      print(userData.toString());
    }
  }

  void loginWithGoogleAndFirebase() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    var res = await _auth.signInWithCredential(credential);
    if (res.additionalUserInfo!.isNewUser) {
      UserService().createUser(
        res.user!.uid,
        res.user!.displayName,
        res.user!.email,
      );
    }
  }

  void loginWithFacebookAndFirebase() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken? accessToken = result.accessToken;

      AuthCredential credential =
          FacebookAuthProvider.credential(accessToken!.token);

      var res = await _auth.signInWithCredential(credential);
      print(res);
      if (res.additionalUserInfo!.isNewUser) {
        UserService().createUser(
          res.user!.uid,
          res.user!.displayName,
          res.user!.email,
        );
      }
    }
  }

  void resetPassword(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  void logout(context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
