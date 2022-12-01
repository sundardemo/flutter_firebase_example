import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class TaskService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addTask(title, desc) {
    _firestore.collection("tasks").add({
      "title": title,
      "description": desc,
      "isCompleted": false,
      "createdAt": FieldValue.serverTimestamp(),
      "uid": FirebaseAuth.instance.currentUser!.uid
    });
  }

  Future getTasks() {
    // _firestore
    //     .collection("tasks")
    //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then((res) {
    //   print(res.docs.length);
    //   for (var i = 0; i < res.docs.length; i++) {
    //     print(res.docs[i].id);
    //     print(res.docs[i].data());
    //   }
    // });

    return _firestore
        .collection("tasks")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .get();
  }

  Stream listenToTasks() {
    return _firestore
        .collection("tasks")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  void updateTask(id, obj) {
    _firestore.collection("tasks").doc(id).update(obj);
  }

  void deleteTask(id) {
    _firestore.collection("tasks").doc(id).delete();
  }

  Future<XFile?> pickImage() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return file;
    } else {
      return null;
    }
  }

  void uploadToFirebaseStorage() async {
    var file = await pickImage();
    var data = await file!.readAsBytes();
    print(file.path);
    var fileRef = await FirebaseStorage.instance
        .ref("tasks")
        .child("taskxx_${file.name}")
        .putData(data, SettableMetadata(contentType: 'image/jpeg'));
    var url = await fileRef.ref.getDownloadURL();
    print(url);
  }
}
