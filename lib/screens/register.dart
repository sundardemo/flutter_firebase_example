import 'package:firebaselearning/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(children: [
        TextField(
          controller: _nameCtrl,
        ),
        TextField(
          controller: _emailCtrl,
        ),
        TextField(
          controller: _passwordCtrl,
        ),
        ElevatedButton(
            onPressed: () {
              AuthService().register(
                context,
                _nameCtrl.text,
                _emailCtrl.text,
                _passwordCtrl.text,
              );
            },
            child: Text("Register")),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text("Login"),
        )
      ]),
    );
  }
}
