import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/screens/home.dart';
import 'package:firebaselearning/screens/login.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ValidateScreen extends StatefulWidget {
  const ValidateScreen({super.key});

  @override
  State<ValidateScreen> createState() => _ValidateScreenState();
}

class _ValidateScreenState extends State<ValidateScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        setState(() {
          _isLoggedIn = false;
        });
      } else {
        setState(() {
          _isLoggedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? HomeScreen() : LoginScreen();
  }
}
