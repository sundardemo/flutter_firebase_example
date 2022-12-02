import 'package:firebaselearning/screens/geo_example.dart';
import 'package:firebaselearning/screens/home.dart';
import 'package:firebaselearning/screens/login.dart';
import 'package:firebaselearning/screens/manage-task.dart';
import 'package:firebaselearning/screens/profile.dart';
import 'package:firebaselearning/screens/register.dart';
import 'package:firebaselearning/screens/reset_password.dart';
import 'package:firebaselearning/screens/validate.dart';
import 'package:firebaselearning/services/push_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationService().registerToken();
  await PushNotificationService().handleNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
        '/manage-task': (context) => ManageTask(),
        '/manage-profile': (context) => ProfileScreen()
      },
      home: ValidateScreen(),
    );
  }
}
