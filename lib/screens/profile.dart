import 'package:firebaselearning/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Profile"),
      ),
      body: Column(children: [
        TextField(
          controller: _nameCtrl,
        ),
        TextField(
          controller: _emailCtrl,
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
            child: Text("Update")),
        TextButton(
          onPressed: () {
            AuthService().logout(context);
          },
          child: Text("Logout"),
        )
      ]),
    );
  }
}
