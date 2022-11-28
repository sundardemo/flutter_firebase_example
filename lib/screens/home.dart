import 'package:firebaselearning/services/auth.dart';
import 'package:firebaselearning/services/task.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/manage-profile');
              },
              icon: const Icon(Icons.account_circle_outlined))
        ],
      ),
      body: StreamBuilder(
        stream: TaskService().listenToTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var task = snapshot.data.docs[index].data();
                  var taskId = snapshot.data.docs[index].id;
                  return ListTile(
                    onLongPress: () {
                      TaskService().deleteTask(taskId);
                    },
                    title: Text(task['title']),
                    subtitle: Text("$taskId - ${task['description']}"),
                    trailing: Switch(
                      onChanged: (value) {
                        TaskService()
                            .updateTask(taskId, {'isCompleted': value});
                      },
                      value: task['isCompleted'],
                    ),
                  );
                });
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text("Something wrong"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // body: FutureBuilder(
      //   future: TaskService().getTasks(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       print(snapshot.data);
      //       return ListView.builder(
      //           itemCount: snapshot.data.docs.length,
      //           itemBuilder: (context, index) {
      //             var task = snapshot.data.docs[index].data();
      //             var taskId = snapshot.data.docs[index].id;
      //             return ListTile(
      //               title: Text(task['title']),
      //               subtitle: Text("$taskId - ${task['description']}"),
      //               trailing: Switch(
      //                 onChanged: (value) {},
      //                 value: task['isCompleted'],
      //               ),
      //             );
      //           });
      //     }
      //     if (snapshot.hasError) {
      //       print(snapshot.error);
      //       return const Center(
      //         child: Text("Something wrong"),
      //       );
      //     }
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/manage-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
