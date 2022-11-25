import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addTask(title, desc) {
    _firestore.collection("tasks").add({
      "title": title,
      "description": desc,
      "isCompleted": false,
      "createdAt": FieldValue.serverTimestamp()
    });
  }
}
