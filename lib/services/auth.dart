import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/services/user.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
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

  void resetPassword(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  void logout(context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
