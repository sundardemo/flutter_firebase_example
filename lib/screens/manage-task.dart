import 'package:firebaselearning/services/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ManageTask extends StatefulWidget {
  const ManageTask({super.key});

  @override
  State<ManageTask> createState() => _ManageTaskState();
}

class _ManageTaskState extends State<ManageTask> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Task")),
      body: Column(children: [
        TextField(
          controller: _titleCtrl,
        ),
        TextField(
          controller: _descCtrl,
        ),
        ElevatedButton(
            onPressed: () {
              TaskService().addTask(_titleCtrl.text, _descCtrl.text);
            },
            child: Text("Add Task"))
      ]),
    );
  }
}
