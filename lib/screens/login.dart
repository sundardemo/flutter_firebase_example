import 'package:firebaselearning/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(children: [
        TextField(
          controller: _emailCtrl,
        ),
        TextField(
          controller: _passwordCtrl,
        ),
        ElevatedButton(
          onPressed: () {
            AuthService().login(context, _emailCtrl.text, _passwordCtrl.text);
          },
          child: Text("Login"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/reset-password');
          },
          child: Text("Lost Password?"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: Text("Register"),
        )
      ]),
    );
  }
}
